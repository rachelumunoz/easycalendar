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

  # when a user cancels an appointment
  # def send_cancellation_notification
  #   # need to add logic
  #   @coach_name = User.find_by(...).first_name
  #   @to_number = User.find_by(...).phone
  #   boot_twilio
  #   sms = @client.messages.create(
  #     from: Rails.application.secrets.twilio_number,
  #     to: @to_number,
  #     body: cancelation_msg
  #   )
  # end

  # when a user is created in the system
  # def send_welcome_message
  #   @to_number = User.find_by(...).phone
  #   boot_twilio
  #   sms = @client.messages.create(
  #     from: Rails.application.secrets.twilio_number,
  #     to: @to_number,
  #     body: welcome_message
  #   )
  # end



  private
 
  def boot_twilio
    account_sid = ENV['TWILIO_SID']
    auth_token = ENV['TWILIO_TOKEN']
    @client = Twilio::REST::Client.new(account_sid, auth_token)
  end

  # COMMANDS
  BOOK_CANCELLED_APPT = "Yes"
  # BOOK_APPT = "Book #{@appt_id}"
  CANCEL_APPT = "Cancel lesson"
  CLOSE_ACCT = "Close"
  COMMAND_OPTIONS = "Commands"
  LIST_BOOKED_APPTS = "Booked"
  # LIST_COACHES = "Coaches"
  # LIST_OPEN_APPTS = "Open"
  # LIST_STUDENTS = "Students"
  PAUSE = "Pause"
  RESUME = "Resume"

  # reformat as case statement?
  def reply_logic
    if @message_body == BOOK_CANCELLED_APPT
      appt_confirmation_msg
    # elsif
    #   @message_body == BOOK_APPT
    #   appt_id = Appointment.find_by(params[:id])
    #   appt_confirmation_msg
    # elsif
    #   @message_body == CANCEL_APPT
    #   cancel_confirmation_msg
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
  def appt_confirmation_msg
    return "Confirmed: you have booked that appointment. We've notified your coach for you."
  end

  def cancel_confirmation_msg
    return "Confirmed: you have canceled the appointment. We've notified your coach for you."
  end

  def cancelation_msg
    return "Coach #{@coach_name} just had an appt open up on #{@day} at #{@start_time} to #{@end_time}. If you want to book this appointment, reply 'Yes'."
  end

  def close_confirmation_msg
    return "Confirmed: you have closed your account. You will not receive any further notifications from EasyCalendar."
  end

  def list_of_commands_msg
    return "'Yes' to book a canceled appt. 'Book' + 'number' to book an open appt (e.g. Book 11 to book appt number eleven). 'Cancel' + 'number' to cancel an appt. 'Close' to close your account (e.g. Cancel 3 to cancel appt number three). 'Commands' to see a list of commands. 'Coaches' to see all your coaches. 'Students' to see all your students. 'Open' to see available appt times. 'Booked' to see your upcoming appts. 'Pause' to stop notifications from EasyCalendar. 'Resume' to restart notifications."
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
    p @user
    @appointments = @user.appointments
    p @appointments
    @appointments.each do |appt|
      "#{appt.start} #{appt.end}"
    end
  end

  def pause_confirmation_msg
    return "Confirmed: you have turned off EasyCalendar notifications. To restart notifications, simply enter the command 'Resume'."
  end

  def resume_notification_msg
    return "Confirmed: you have turned EasyCalendar notifications on."
  end

  def welcome_msg
    return "Welcome to Easy Calendar! Through our unique text message user interface, EasyCalendar offers you a convenient way of managing appointments with your coaches. Enter 'Commands' to see a list of available commands. You can also log into your account at https://EasyCalendar.co"
  end

  def appointments
    
  end
  # def msg_recipient
  #   if @from_number == "+14785424512"
  #     return ", Ian"
  #   else
  #     return ""
  #   end
  # end

end
