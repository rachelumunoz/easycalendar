require 'googleauth'
require 'googleauth/stores/redis_token_store'
require 'google/apis/calendar_v3'
require 'googleauth/stores/file_token_store'
require 'dotenv'
require 'google/api_client/client_secrets'


class GoogleEvent
  OOB_URI = "http://localhost:3000/users/auth/google_oauth2/callback"
  attr_writer :authorizer, :redirect_uri, :credentials
  attr_accessor :summary
  # :event
  def initialize
    client_id = Google::Auth::ClientId.new(ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'])
    scope = ['https://www.googleapis.com/auth/calendar,https://www.google.com/m8/feeds/,https://www.googleapis.com/auth/plus.login']
    token_store =  Google::Auth::Stores::RedisTokenStore.new(redis: $redis, url: ENV['REDIS_URL'])
    @authorizer =  Google::Auth::UserAuthorizer.new(client_id, scope, token_store)
    user_id = "default"
    @credentials = @authorizer.get_credentials(user_id)
    @event = Google::Apis::CalendarV3::Event.new
    # @event.authorization = @credentials
    # puts "**********************summary********************************"
    # puts @event.summary
    # puts "***********************location*******************************"
    # puts @event.location
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

  def new_event
      self.summary = "hello"
  end
end
