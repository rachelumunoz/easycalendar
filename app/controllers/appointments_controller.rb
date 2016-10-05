class AppointmentsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @appointments = Appointment.where(start: params[:start]..params[:end])
  end

  def show
  end

  def new
    @user = current_user
    #@user = User.find(3)
    @appointment = Appointment.new
  end

  def edit
    @user = current_user
    #@user = User.find(3)
    #@appointment = Appointment.new
  end

  def create
    @appointment = Appointment.new(event_params)
    @appointment.set_color
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
      params.require(:appointment).permit(:coach_activity_id, :child_id, :location_id, :start, :end, :color)
    end
end
