require 'time'

class AppointmentsController < MessagesController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @appointments = Appointment.where(start: params[:start]..params[:end])
  end

  def show
  end

  def new
    @user = current_user
    @appointment = Appointment.new
  end

  def edit
    @user = current_user
    @appointment = Appointment.find_by(id: params[:id])

    @event_id = @appointment.google_event_id
  end

  def create
    @appointment = Appointment.new(event_params)
    @appointment.set_color
    @appointment.save

    if @appointment.google_event_id.nil?
      event = Google::Apis::CalendarV3::Event.new(
      {  summary: @appointment.child.first_name,
      location: @appointment.location.address,
      start: {
        date_time: @appointment.start.utc.iso8601
      },
      end: {
        date_time: @appointment.end.utc.iso8601
      }
      })
      authorization = GoogleAuthorization.authorize(current_user.email,request)
      if authorization.is_a? String
        redirect_to authorization
      else
        @service = Google::Apis::CalendarV3::CalendarService.new
        @service.client_options.application_name = "Easycalendar"

        @service.authorization = authorization
        @service.insert_event('primary', event)
      end
    end
    redirect_to '/schedule'
  end

  def update
    @appointment.update(event_params)
    @appointment.set_color
    if @appointment.child_id == nil
      cancel_confirmation_msg
    end

    authorization = GoogleAuthorization.authorize(current_user.email,request)

    if authorization.is_a? String
      redirect_to authorization
    else
      @service = Google::Apis::CalendarV3::CalendarService.new
      @service.client_options.application_name = "Easycalendar"
      @service.authorization = authorization

      event = @service.get_event('primary', @appointment.google_event_id)
      event.summary = @appointment.activity.name
      event.start.date_time = @appointment.start.utc.iso8601
      event.end.date_time = @appointment.end.utc.iso8601
      result = @service.update_event('primary',event.id, event)
      result
    end
  end

  def destroy
    authorization = GoogleAuthorization.authorize(current_user.email,request)
    if authorization.is_a? String
      redirect_to authorization
    else
      @service = Google::Apis::CalendarV3::CalendarService.new
      @service.client_options.application_name = "Easycalendar"
      @service.authorization = authorization
      @service.delete_event('primary', @appointment.google_event_id)
    end
    @appointment.destroy
    redirect_to profile_path
  end

  private
    def set_event
      @appointment = Appointment.find(params[:id])
    end

    def event_params
      params.require(:appointment).permit(:coach_activity_id, :child_id, :location_id, :start, :end, :color)
    end
end
