class InvitesController < MessagesController
  def new
    @user = current_user
    @new_user = User.new
    @new_child = Child.new
    @invite = Invite.new
  end

  def create
    @user = current_user
    @new_user = User.new
    @new_user.email = params[:invite][:user][:email]
    @new_user.phone_number = "+1" + params[:invite][:user][:phone_number]
    @new_user.password = "password"
    @new_user.save

    @new_child = Child.new
    @new_child.first_name = params[:invite][:child][:first_name]
    @new_child.last_name = params[:invite][:child][:last_name]
    @new_child.age = params[:invite][:child][:age].to_i
    @new_child.parent_id = @new_user.id
    @new_child.save

    @invite = Invite.new
    @invite.coach_activity_id = params[:invite][:coach_activity_id].to_i
    @invite.client_id = @new_user.id
    @invite.save

    invitation_notice
    redirect_to "/schedule"
  end

end
