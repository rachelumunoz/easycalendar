class UsersController < ActionController::Base

  def show
    @testuser = User.find(1)
    @appointments = @testuser.appointments
  end

end
