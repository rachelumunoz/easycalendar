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
  #      event = Google::Apis::CalendarV3::Event.new(
  # {
  #   summary: 'Google I/O 2015',
  #   location: '800 Howard St., San Francisco, CA 94103',
  #   description: 'A chance to hear more about Google\'s developer products.',
  #   start: {
  #     date_time: '2016-10-15T09:00:00-07:00',
  #     time_zone: 'America/Los_Angeles',
  #   },
  #   end: {
  #     date_time: '2016-10-15T17:00:00-07:00',
  #     time_zone: 'America/Los_Angeles',
  #   },
  #   recurrence: [
  #     'RRULE:FREQ=DAILY;COUNT=2'
  #   ],
  #   attendees: [
  #     {email: 'lpage@example.com'},
  #     {email: 'sbrin@example.com'},
  #   ]
  # })
    authorization = GoogleAuthorization.authorize(current_user.email,request)
    if authorization.is_a? String
      redirect_to authorization
    else
      @service = Google::Apis::CalendarV3::CalendarService.new
      @service.client_options.application_name = "Easycalendar"

      @service.authorization = authorization
      @service.insert_event('primary', event)
      current_user.get_google_calendars
      @events = current_user.events
      current_user.events_to_appointments
      @coached_appointments = current_user.coached_appointments
      @appointments = current_user.appointments
    end

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
