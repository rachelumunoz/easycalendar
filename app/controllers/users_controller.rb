class UsersController < ActionController::Base

  def show
    @testuser = User.find(8)
    @appointments = @testuser.appointments
    @c_appointments = @testuser.coached_appointments
  end

end
