class EventsController < ApplicationController
  before_action :set_event

  def show
    current_user.get_google_calendars
  end

  def edit

  end

  def update

  end

  private
  def set_event
    @event = Event.find(params[:id])
  end
end
