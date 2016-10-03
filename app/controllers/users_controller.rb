class UsersController < ApplicationController

  def show
    #@user = current_user
    @user = User.find(6)
    # @appointments = @testuser.appointments
    # @c_appointments = @testuser.coached_appointments
  end

end
