class MessagesController < ApplicationController 

 skip_before_filter :verify_authenticity_token
 # skip_before_filter :authenticate_user!, :only => "reply"

 # when a user has sent an SMS to EasyCalendar
  def send_reply
    @message_body = params["Body"]
    @from_number = params["From"]
    interpret_command
    boot_twilio
    sms = @client.messages.create(
      from: Rails.application.secrets.twilio_number,
      to: @from_number,
      body: reply_message
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
    account_sid = Rails.application.secrets.twilio_sid
    auth_token = Rails.application.secrets.twilio_token
    @client = Twilio::REST::Client.new account_sid, auth_token
  end

  # COMMANDS
  # @appt_id = Appointment.find_by(params[:id])
  @book_cancelled_appt = "Yes"
  # @book_open_appt = "Book #{@appt_id}"
  @cancel_appt = "Cancel"
  @close_account = "Close"
  @command_options = "Commands"
  @linked_coaches = "Coaches"
  @linked_students = "Students"
  @list_open_appts = "Open"
  @list_booked_appts = "Booked"
  @pause_notification = "Pause"
  @resume_notification = "Resume"

  # reformat as case statement?
  def interpret_command
    if @message_body == @book_cancelled_appt
      appt_confirmation_msg
    elsif
      @message_body == @book_open_appt
      appt_confirmation_msg
    elsif
      @message_body == @cancel_appt
      cancel_confirmation_msg
    elsif
      @message_body == @close_account
      close_confirmation_msg
    elsif
      @message_body == @command_options
      list_of_commands_msg
    elsif
      @message_body == @linked_coaches
      list_of_linked_coaches
    elsif
      @message_body == @linked_students
      list_of_linked_students
    elsif
      @message_body == @list_open_appts
      list_of_appt_openings
    elsif
      @message_body == @list_booked_appts
      list_of_appts
    elsif
      @message_body == @pause_notification
      pause_confirmation_msg
    elsif
      @message_body == @resume_notification
      resume_notification_msg
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
    return "Confirmed: you have closed your account. We've notified your coach for you."
  end

  def list_of_commands_msg
    return <<-COMMANDS
      'Yes' to book a canceled appt. 
      'Book' + 'number' to book an open appt (e.g. Book 11 to book appt number eleven). 
      'Cancel' to cancel an appt. 
      'Close' to close your account. 
      'Commands' to see a list of commands. 
      'Coaches' to see all your coaches. 
      'Students' to see all your students. 
      'Open' to see available appt times. 
      'Booked' to see your upcoming appts. 
      'Pause' to stop notifications from EasyCalendar. 
      'Resume' to restart notifications.
    COMMANDS
  end

  # def list_of_linked_coaches
  #   @coaches = Coach.find_by(params[:id])
  #     return "Your coaches are:"
  #   @coaches.each do |coach|
  #     return coach
  #   end
  # end

  # def list_of_linked_students
  #   @students = Child.find_by(params[:id])
  #     return "Your students are:"
  #   @students.each do |student|
  #     return student
  #   end
  # end

  # def list_of_appt_openings
  #   @available_appointments = Appointment.find_by(params[:id]).where(params[:child_id]==params[:id])
  #     return "Your students are:"
  #   @available_appointments.each do |appt|
  #     return appt
  #   end
  # end

  # def list_of_appts
  #   @appointments = Appointment.find_by(params[:id]).where(params[:child_id]==nil)
  #     return "Your students are:"
  #   @appointments.each do |appt|
  #     return appt
  #   end
  # end

  def pause_confirmation_msg
    return "Confirmed: you have turned off EasyCalendar notifications. To restart notifications, simply enter the command 'Resume'."
  end

  def resume_notification_msg
    return "Confirmed: you have turned EasyCalendar notifications on."
  end

  def welcome_msg
    return "Welcome to Easy Calendar! Through our unique text message user interface, EasyCalendar offers you a convenient way of managing appointments with your coaches. Enter 'Commands' to see a list of available commands. You can also log into your account at https://EasyCalendar.co"
  end

  # def msg_recipient
  #   if @from_number == "+14785424512"
  #     return ", Ian"
  #   else
  #     return ""
  #   end
  # end

end
