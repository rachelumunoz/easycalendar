require 'googleauth'
require 'googleauth/stores/redis_token_store'
require 'google/apis/calendar_v3'
require 'googleauth/stores/file_token_store'
require 'dotenv'
require 'google/api_client/client_secrets'

module GoogleAuthorization
  OOB_URI = "http://localhost:3000/users/auth/google_oauth2/callback"

  def self.authorize(email, request, code = nil)
    puts "Inside authorize"
    client_id = Google::Auth::ClientId.new(ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'])
    token_store =  Google::Auth::Stores::RedisTokenStore.new(redis: REDIS)
    scope = ['https://www.googleapis.com/auth/calendar']
    authorizer = Google::Auth::WebUserAuthorizer.new(client_id, scope, token_store, '/users/auth/google_oauth2/callback')
    user_id = email
    credentials = user_id ? authorizer.get_credentials(user_id, request) : nil
    if credentials.nil?
      return authorizer.get_authorization_url(base_url: OOB_URI, request: request) if code.nil?
      credentials = authorizer.get_and_store_credentials_from_code(
        user_id: user_id, code: code , base_url: OOB_URI)
    end
    puts "==========it got to credentials======================="
    credentials
  end

end
