class MessagesController < ApplicationController 
 skip_before_filter :verify_authenticity_token
 # the following skip method is for use with Devise
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
  BOOK_CANCELLED_APPT = "yes"
  BOOK_APPT = "book"
  CANCEL_APPT = "cancel"
  CLOSE_ACCT = "close account"
  COMMAND_OPTIONS = "commands"
  LIST_BOOKED_APPTS = "booked"
  LIST_COACHES = "coaches"
  LIST_OPEN_APPTS = "open"
  LIST_STUDENTS = "students"
  PAUSE = "pause"
  RESUME = "resume"

  def reply_logic
    @message_body = @message_body.downcase.split.join(" ")
    @message_body.gsub!(/[|()!@#$%^&*.,]/," ");
    @message_body = @message_body.split.join(" ")

    @argv = @message_body.split(" ")

    @user = User.find_by(phone_number: @from_number)

    if @user == nil 
      nil_user_msg
    elsif
      @argv[0] == BOOK_CANCELLED_APPT
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
      @argv[0] == PAUSE
      pause_confirmation_msg
    elsif
      @argv[0] == RESUME
      resume_notification_msg
    else
      return "I'm sorry, I didn't understand your message. Please enter 'Commands' to see a list of messages to which I can respond."
    end
  end

  # SYSTEM MESSAGES
  def nil_user_msg
    return "You are not currently a user. Please contact your coach or visit www.easycalendar.com to create an account."
  end

  def appt_confirmation_msg
    @user = User.find_by(phone_number: @from_number)
    if @argv[2]
      @child = @user.children.find_by(first_name: @argv[2])
    else
      @child = @user.children.first
    end
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
    
    receivers = @clients.reject{|client| client == @user || !client.client_invites.first.notification}
    
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
    @user = User.find_by(phone_number: @from_number)
    @user.update_attributes(status: "Inactive")
    return "Confirmed: you have closed your account. You will not receive any further notifications from EasyCalendar."
  end

  def list_of_commands_msg
    return "'Yes' + 'Appt ID' to book a canceled appt (e.g. Yes 234).\n\n'Book' + 'Appt ID' to book an open appt.\n\n'Cancel' + 'Appt ID' to cancel an appt.\n\n'Close' to close your account.\n\n'Commands' to see a list of commands.\n\n'Coaches' to see all your coaches.\n\n'Students' to see all your students.\n\n'Open' to see available appointment times for all your coaches.\n\n'Booked' to see your upcoming appts.\n\n'Pause' to stop notifications from EasyCalendar.\n\n'Resume' to restart notifications."
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

  def pause_confirmation_msg
    @user = User.find_by(phone_number: @from_number)
    @coach = @user.coaches.find_by(first_name: @argv[1].capitalize)
    @coach_activities = CoachActivity.where(coach: @coach)
    @coach_activities.each do |coach_activity|
      @invite = @user.client_invites.find_by(coach_activity: coach_activity)
      @invite.notification = false
      @invite.save
    end
    return "Confirmed: you have turned off EasyCalendar notifications for Coach #{@coach.first_name}; to restart, simply enter the command 'Resume #{@coach.first_name}'."
  end

  def resume_notification_msg
    @user = User.find_by(phone_number: @from_number)
    @coach = @user.coaches.find_by(first_name: @argv[1].capitalize)
    @coach_activities = CoachActivity.where(coach: @coach)
    @coach_activities.each do |coach_activity|
      @invite = @user.client_invites.find_by(coach_activity: coach_activity)
      @invite.notification = true
      @invite.save
    end
    return "Confirmed: you have turned on EasyCalendar notifications for Coach #{@coach.first_name}."
  end

  def invitation_notice
    boot_twilio
    @client.account.messages.create({
      :from => ENV["TWILIO_NUMBER"],
      :to => @new_user.phone_number,
      :body => invitation_message
      })
  end

  def invitation_message
    return "Welcome to EasyCalendar!"
  end

end
