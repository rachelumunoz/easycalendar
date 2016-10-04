class MessagesController < ApplicationController 

 skip_before_filter :verify_authenticity_token
 # skip_before_filter :authenticate_user!, :only => "reply"

 # when a user has sent an SMS to EasyCalendar
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
  # BOOK_APPT = "Book #{@appt_id}"
  CANCEL_APPT = "Cancel"
  CLOSE_ACCT = "Close"
  COMMAND_OPTIONS = "Commands"
  LIST_BOOKED_APPTS = "Booked"
  # LIST_COACHES = "Coaches"
  # LIST_OPEN_APPTS = "Open"
  # LIST_STUDENTS = "Students"
  PAUSE = "Pause"
  RESUME = "Resume"







  def reply_logic
    @argv = @message_body.split(" ")

    if @message_body == BOOK_CANCELLED_APPT
      appt_confirmation_msg
    # elsif
    #   @message_body == BOOK_APPT
    #   appt_id = Appointment.find_by(params[:id])
    #   appt_confirmation_msg    
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
    # elsif
    #   @message_body == LIST_COACHES
    #   list_of_linked_coaches
    # elsif
    #   @message_body == LIST_OPEN_APPTS
    #   list_of_appt_openings
    # elsif
    #   @message_body == LIST_STUDENTS
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
  # def appt_confirmation_msg
  #   return "Confirmed: you have booked that appointment. We've notified your coach for you."
  # end

  # def cancel_confirmation_msg
  #   @user = User.find_by(phone_number: @from_number)
  #   @appoinment = @user.appointment[@message_body[1]-1]
  #   p "==================="
  #   p @appointment
  #   return @appointment.start
  #   # return "Confirmed: you have canceled the appointment. We've notified your coach for you."
  # end

  def cancel_confirmation_msg
    @user = User.find_by(phone_number: @from_number)
    @appointment = @user.appointments[@argv[1].to_i - 1]
    @appointment.update_attributes(child: nil)
    @coach = @appointment.coach
    @clients = @coach.clients

    @parent_ary = []
    @clients.each do |client|
      @parent_ary << client
    end
    @parent_ary.delete_if {|user| user == @user}
    
    cancelation_notice
    return "Confirm Cancel #{@appointment.child}"
  end

  def cancelation_notice
    boot_twilio
    @parent_ary.each do |parent|
      @client.account.messages.create({
        :from => ENV["TWILIO_NUMBER"],
        :to => parent.phone_number,
        :body => canceled_appt_details
        })
    end
  end

  def canceled_appt_details
    "An appt is available"
    # "Appt #{index+1}: #{appt.child.first_name} #{appt.start.strftime("%-m/%d")}\n#{appt.start.strftime("%l:%M")}-#{appt.end.strftime("%l:%M%P")}\n\n"
  end

  def close_confirmation_msg
    return "Confirmed: you have closed your account. You will not receive any further notifications from EasyCalendar."
  end

  def list_of_commands_msg
    return "'Yes' to book a canceled appt.\n\n'Book' + 'number' to book an open appt (e.g. Book 11 to book appt number eleven).\n\n'Cancel' + 'number' to cancel an appt.\n\n'Close' to close your account (e.g. Cancel 3 to cancel appt number three).\n\n'Commands' to see a list of commands.\n\n'Coaches' to see all your coaches.\n\n'Students' to see all your students.\n\n'Open' to see available appt times.\n\n'Booked' to see your upcoming appts.\n\n'Pause' to stop notifications from EasyCalendar.\n\n'Resume' to restart notifications."
  end

  # # def list_of_linked_coaches
  # #   @coaches = Coach.find_by(params[:id])
  # #     return "Your coaches are:"
  # #   @coaches.each do |coach|
  # #     return coach
  # #   end
  # # end

  # # def list_of_linked_students
  # #   @students = Child.find_by(params[:id])
  # #     return "Your students are:"
  # #   @students.each do |student|
  # #     return student
  # #   end
  # # end

  # # def list_of_appt_openings
  # #   @available_appointments = Appointment.find_by(params[:id]).where(params[:child_id]==params[:id])
  # #     return "Your students are:"
  # #   @available_appointments.each do |appt|
  # #     return appt
  # #   end
  # # end

  def list_of_appts
    @user = User.find_by(phone_number: @from_number)
    @appointments = @user.appointments
    appointment_list = ""
    @appointments.each_with_index do |appt, index|
      appointment_list << "Appt #{index+1}: #{appt.child.first_name} #{appt.start.strftime("%-m/%d")}\n#{appt.start.strftime("%l:%M")}-#{appt.end.strftime("%l:%M%P")}\n\n"
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
