class MessagesController < ApplicationController 

 skip_before_filter :verify_authenticity_token
 # skip_before_filter :authenticate_user!, :only => "reply"

  def reply
    @message_body = params["Body"]
    @from_number = params["From"]
    boot_twilio
    sms = @client.messages.create(
      from: ENV['TWILIO_NUMBER'],
      to: @from_number,
      body: reply_logic
    )
  end

  private
 
  def boot_twilio
    account_sid = ENV['TWILIO_SID']
    auth_token = ENV['TWILIO_TOKEN']
    @client = Twilio::REST::Client.new(account_sid, auth_token)
  end

  # COMMANDS
  BOOK_CANCELLED_APPT = "Yes"
  BOOK_APPT = "Book"
  CANCEL_APPT = "Cancel"
  CLOSE_ACCT = "Close"
  COMMAND_OPTIONS = "Commands"
  LIST_BOOKED_APPTS = "Booked"
  LIST_COACHES = "Coaches"
  LIST_OPEN_APPTS = "Open"
  LIST_STUDENTS = "Students"
  PAUSE = "Pause"
  RESUME = "Resume"

  def reply_logic
    @argv = @message_body.split(" ")

    if @argv[0] == BOOK_CANCELLED_APPT
      appt_confirmation_msg
    elsif
      @argv[0] == BOOK_APPT
      appt_confirmation_msg    
    elsif
      @argv[0] == CANCEL_APPT
      cancel_confirmation_msg
    elsif
      @message_body == CLOSE_ACCT
      close_confirmation_msg
    elsif
      @message_body == COMMAND_OPTIONS
      list_of_commands_msg
    elsif
      @message_body == LIST_BOOKED_APPTS
      list_of_appts
    elsif
      @message_body == LIST_COACHES
      list_of_linked_coaches
    elsif
      @message_body == LIST_OPEN_APPTS
      list_of_appt_openings
    elsif
      @message_body == LIST_STUDENTS
    #   list_of_linked_students
    elsif
      @message_body == PAUSE
      pause_confirmation_msg
    elsif
      @message_body == RESUME
      resume_notification_msg
    else
      return "I'm sorry, I didn't understand your message. Please enter 'Commands' to see a list of messages to which I can respond."
    end
  end

  def welcome_message
      welcome_msg
  end

  # SYSTEM MESSAGES

  def appt_confirmation_msg
    @user = User.find_by(phone_number: @from_number)
    @child = @user.children.find_by(first_name: @argv[2])
    @appointment = Appointment.find(@argv[1].to_i)
    @appointment.update_attributes(child: @child)
    return "Great! You've booked appointment #{@appointment.id} for #{@appointment.child.first_name}. I have notified #{@appointment.coach.first_name} for you."
  end

  def cancel_confirmation_msg
    @user = User.find_by(phone_number: @from_number)
    @appointment = @user.appointments.find(@argv[1].to_i)
    @child = @appointment.child.first_name
    @appointment.update_attributes(child: nil)
    @coach = @appointment.coach
    @clients = @coach.clients
    
    receivers = @clients.reject{|client| client == @user}
    
    Notification.create(
      appointment: @appointment, 
      receivers: receivers,
      content: canceled_appt_details)

    cancelation_notice(receivers)
    return "Alright, I have canceled #{@child}'s appointment (ID #{@appointment.id}) and notified #{@coach.first_name} for you."
  end

  def cancelation_notice(receivers)
    boot_twilio
    receivers.each do |parent|
      @client.account.messages.create({
        :from => ENV["TWILIO_NUMBER"],
        :to => parent.phone_number,
        :body => canceled_appt_details
        })
    end
  end

  def canceled_appt_details
    "Coach #{@coach.first_name} just had the following appointment open up.\n
    Appt ID: #{@appointment.id}
    Location: #{@appointment.location.name}
    Date: #{@appointment.start.strftime("%-m/%d")}
    Time: #{@appointment.start.strftime("%l:%M")}-#{@appointment.end.strftime("%l:%M%P")}\n\nIf you would like to book this, please reply 'Yes' along with the Appt ID (e.g. Yes 109). If you have more than one child who trains with this coach, you should enter his or her name, too (e.g. Yes 109 Emma)."
  end

  def close_confirmation_msg
    return "Confirmed: you have closed your account. You will not receive any further notifications from EasyCalendar."
  end

  def list_of_commands_msg
    return "'Yes' + 'number' + 'your child's name' to book a canceled appt (e.g. Yes 234 Emma).\n\n'Book' + 'number' + 'your child's name' to book an open appt.\n\n'Cancel' + 'number' to cancel an appt.\n\n'Close' to close your account.\n\n'Commands' to see a list of commands.\n\n'Coaches' to see all your coaches.\n\n'Students' to see all your students.\n\n'Open' to see available appointment times for all your coaches.\n\n'Booked' to see your upcoming appts.\n\n'Pause' to stop notifications from EasyCalendar.\n\n'Resume' to restart notifications."
  end

  def list_of_linked_coaches
    @user = User.find_by(phone_number: @from_number)
    @coaches = @user.coaches
    coach_list = ""
    @coaches.each_with_index do |coach, index|
      coach_list << "Coach #{index+1}: #{coach.first_name} #{coach.last_name}"
    end
    return coach_list
  end

  # # def list_of_linked_students
  # #   @students = Child.find_by(params[:id])
  # #     return "Your students are:"
  # #   @students.each do |student|
  # #     return student
  # #   end
  # # end

  def list_of_appt_openings
    @user = User.find_by(phone_number: @from_number)
    @coaches = @user.coaches

    open_appts_ary = []

    @coaches.each do |coach|
      coach.coached_appointments.where(child_id: nil).find_each do |open_appt|
        open_appts_ary << open_appt
      end
    end

    open_appts_list = ""

    open_appts_ary.each_with_index do |appt, index|
      open_appts_list << "Appt ID #{appt.id}: Coach #{appt.coach.first_name}\nLocation: #{appt.location.name}\nDate: #{appt.start.strftime("%-m/%d")}\nTime: #{appt.start.strftime("%l:%M")}-#{appt.end.strftime("%l:%M%P")}\n\n"
    end

    open_appts_list << "To book one of these appointments, reply Yes plus the number of the appointment (e.g. Yes 1)."
    return open_appts_list
  end

  def list_of_appts
    @user = User.find_by(phone_number: @from_number)
    @appointments = @user.appointments
    appointment_list = ""
    @appointments.each_with_index do |appt, index|
      appointment_list << "Appt ID #{appt.id}: #{appt.child.first_name} #{appt.start.strftime("%-m/%d")}\n#{appt.start.strftime("%l:%M")}-#{appt.end.strftime("%l:%M%P")}\n\n"
    end
    return appointment_list
  end

  # def pause_confirmation_msg
  #   return "Confirmed: you have turned off EasyCalendar notifications. To restart notifications, simply enter the command 'Resume'."
  # end

  # def resume_notification_msg
  #   return "Confirmed: you have turned EasyCalendar notifications on."
  # end

  # def welcome_msg
  #   return "Welcome to Easy Calendar! Through our unique text message user interface, EasyCalendar offers you a convenient way of managing appointments with your coaches. Enter 'Commands' to see a list of available commands. You can also log into your account at https://EasyCalendar.co"
  # end

end
