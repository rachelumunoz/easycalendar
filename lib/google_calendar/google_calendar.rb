require 'googleauth'
require 'googleauth/stores/redis_token_store'
require 'google/apis/calendar_v3'
require 'googleauth/stores/file_token_store'
require 'dotenv'
require 'google/api_client/client_secrets'

class Event
  OOB_URI = "http://localhost:3000/users/auth/google_oauth2/callback"
  attr_writer :authorizer, :event, :redirect_uri, :credentials

  def initialize
    client_id = Google::Auth::ClientId.new(ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'])
    scope = ['userinfo.email,calendar, https://www.googleapis.com/auth/calendar, https://www.google.com/m8/feeds/, https://www.googleapis.com/auth/plus.login']
    token_store =  Google::Auth::Stores::RedisTokenStore.new(redis: $redis)
    @authorizer = @authorizer = Google::Auth::UserAuthorizer.new(client_id, scope, token_store)
    user_id = current_user.email
    @credentials = @authorizer.get_credentials(user_id)
    @event = Google::Apis::CalendarV3::Event.new
    @event.authorization = @credentials
  end

  def authorization_url
    @authorizer.get_authorization_url(base_url: OOB_URI)
  end

  def get_credentials
    @credentials
  end

  def set_authorization
    @event.authorization = @credentials
  end

  def get_event
    @event
  end

  def save_credentials
    user_id = current_user.email
    @credentials = @authorizer.get_and_store_credentials_from_code(
      user_id: user_id, code: code, base_url: OOB_URI)
    @drive.authorization = @credentials
  end
end
