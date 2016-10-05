class InvitesController < MessagesController
  def new
    @user = current_user
    @new_user = User.new
    @invite = Invite.new
  end

  def create
    @user = current_user
    @new_user = User.new
    @new_user.email = params[:invite][:user][:email]
    @new_user.phone_number = params[:invite][:user][:phone_number]
    @new_user.password = "password"
    @new_user.save

    @invite = Invite.new
    @invite.coach_activity_id = params[:invite][:coach_activity_id].to_i
    @invite.client_id = @new_user.id
    @invite.save
    invitation_notice
    redirect_to profile_path
  end

end
