class EventsController < ApplicationController
  before_action :set_event, except: :index

  def show
  end

  def new
    @event = Event.new(params)
  end

  def create
  end


  #should attach service to each user/coach
  def index
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
