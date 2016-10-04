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
  end

  def show

  end

  def calendar
    @calendar = Google::Apis::CalendarV3::Calendar.new(
      summary: 'calendarSummary',
      time_zone: 'America/Los_Angeles'
      )
  end
end
