class EventsController < ApplicationController
  before_action :set_event, except: :index

  def show

  end

  def new

  end

  def create

  end


  #should attach service to each user/coach
  def index
    # current_user.get_google_calendars
    # @events = current_user.events
    @service = Google::Apis::CalendarV3::CalendarService.new
    @service.client_options.application_name = "Easycalendar"

    #need authorization

    #need to check if authorization is there if not
      # send to redirect of url
      #get code
    #else

    @service.authorization = GoogleAuthorization.authorize_part_one






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
