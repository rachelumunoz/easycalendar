class UsersController < ApplicationController


  def index
    if current_user.token_expired?
      puts "expired"
    else
      puts "not expired"
    end
    current_user.refresh_token_if_expired
    @events = current_user.get_google_calendars
  end

  def show

  end

end
