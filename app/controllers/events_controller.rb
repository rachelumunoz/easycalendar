class EventsController < ApplicationController
  before_action :set_event, except: :index

  def show

    # @events = current_user.events
  end

  def new

  end

  def create

  end


  #should attach service to each user/coach
  def index
    # # current_user.get_google_calendars
    # # @events = current_user.events
    # @service = Google::Apis::CalendarV3::CalendarService.new
    # @service.client_options.application_name = "Easycalendar"

    # @service.authorization = GoogleAuthorization.authorize_part_one
    # if @return.class == "string"
    #   redirect_to "/ + #{ @return} "
    # else
    #   puts "=======================yay========================"
    # end
    # #need authorization
    current_user.get_google_calendars
    @events = current_user.events
    current_user.events_to_appointments
    @appointments = current_user.coached_appointments
  end


  def edit

  end

  def update
    # @event.update_attributes
    puts "=================params=================="
    puts params[:status]
  end

  private
  def set_event
    @event = Event.find(params[:id])
  end
end
