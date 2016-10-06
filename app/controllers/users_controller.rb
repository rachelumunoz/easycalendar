require 'google/apis/calendar_v3'

class UsersController < ApplicationController


  def events
    # if current_user.token_expired?
    #   puts "*************expired******************"
    # else
    #   puts "************not expired****************"
    # end
    # current_user.refresh_token_if_expired
    # current_user.get_google_calendars
    # render json: @events
    # @event = Google::Apis::CalendarV3::Event.new
    # @event.authorization = credentials_for(Google::Apis::CalendarV3::AUTH_CALENDAR)
    # calendar_id = 'primary'
    # @result = calendar.list_events(calendar_id,
    #                              max_results: 10,
    #                              single_events: true,
    #                              order_by: 'startTime',
    #                              time_min: Time.now.iso8601)
    # @events = current_user.get_google_calendars
  end

  def show
    @user = current_user
    #@user = User.find(6)
    # @appointments = @testuser.appointments
    # @c_appointments = @testuser.coached_appointments
  end

  def edit
    @user = current_user
    @new_coach_activity = CoachActivity.new
    @activities = Activity.all
    #@user = User.find(6)
    # @appointments = @testuser.appointments
    # @c_appointments = @testuser.coached_appointments
  end

  def update
    @user = current_user
    @activities = Activity.all
    @new_coach_activity = CoachActivity.new
    @user.first_name = params[:user][:first_name]
    @user.last_name = params[:user][:last_name]
    @user.phone_number = params[:user][:phone_number]
    @user.save
    p "----------(>_<)----------"

    @new_coach_activity.activity_id = params[:user][:coach_activity][:activity_id].to_i
    @new_coach_activity.coach_id = @user.id
    existing_coach_activity = CoachActivity.find_by(activity_id: @new_coach_activity.activity_id, coach_id: @user.id)

    if existing_coach_activity
      p "do nothing"
    else
      p "saved"
      @new_coach_activity.save
    end
    redirect_to "/schedule"
  end

  def calendar

  end

  def showappts
    @user = current_user
    @appointments = @user.coached_appointments
  end


  def invite
    #@user = current_user

  end

end
