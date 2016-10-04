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
    @user = current_user
    @appointment = Appointment.new
  end

  def edit
  end

  def create
    @appointment = Appointment.new(event_params)
    @appointment.save
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
      params.require(:event).permit(:title, :date_range, :start, :end, :color)
    end
end
