class AppointmentsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @appointments = Appointment.where(start: params[:start]..params[:end])
  end

  def show
  end

  def new
    p "************************************** #{current_user.email}"
    p current_user.clients
    #@user = current_user
    @user = current_user
    @appointment = Appointment.new
  end

  def edit
    @user = current_user
    #@appointment = Appointment.new
  end

  def create
    @appointment = Appointment.new(event_params)
    @appointment.set_color
    @appointment.save
    puts "===========hello============="
    #creat google event
    event = Google::Apis::CalendarV3::Event.new(
    {  summary: "#{@appointment.activity.name}",
      location: @appointment.location.address,
      start: {
        date_time: "2016-10-06T09:00:00-07:00"
      },
      end: {
        date_time: "2016-10-06T09:30:00-07:00"
      }
      })
    puts "==============event==============="
    puts event.class
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

  def update
    @appointment.update(event_params)
    @appointment.set_color
  end

  def destroy
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
