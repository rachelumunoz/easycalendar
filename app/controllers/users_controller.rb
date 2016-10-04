require 'google/apis/calendar_v3'

class UsersController < ApplicationController


  def events
    # if current_user.token_expired?
    #   puts "*************expired******************"
    # else
    #   puts "************not expired****************"
    # end
    # current_user.refresh_token_if_expired
    current_user.get_google_calendars
    # render json: @events
    @event = Google::Apis::CalendarV3::Event.new
    @event.authorization = credentials_for(Google::Apis::CalendarV3::AUTH_CALENDAR)
    calendar_id = 'primary'
    @result = calendar.list_events(calendar_id,
                                 max_results: 10,
                                 single_events: true,
                                 order_by: 'startTime',
                                 time_min: Time.now.iso8601)
  end

  def show

  end

  def calendar

  end
end
