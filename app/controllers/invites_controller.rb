class InvitesController < ApplicationController
  def new
    @user = User.find(3)
    @new_user = User.new
    @invite = Invite.new
  end

  def create
    # user that is logged in, replace w/ current_user when fully implemented
    @user = User.find(3)
    @new_user = User.new
    @new_user.email = params[:invite][:user][:email]
    @new_user.phone_number = params[:invite][:user][:phone_number]
    @new_user.password = "password"
    @new_user.save
    p @new_user

    @invite = Invite.new
    @invite.coach_activity_id = params[:invite][:coach_activity_id].to_i
    @invite.client_id = @new_user.id
    p "pre-save----------2:(>.<)----------"
    p @invite
    @invite.save
    p "post-save----------2:(^_^)----------"
    redirect_to profile_path
  end

end
