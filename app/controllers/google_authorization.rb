require 'googleauth'
require 'googleauth/stores/redis_token_store'
require 'google/apis/calendar_v3'
require 'googleauth/stores/file_token_store'
require 'dotenv'
require 'google/api_client/client_secrets'

module GoogleAuthorization
 OOB_URI = "http://localhost:3000/users/auth/google_oauth2/callback"

  def self.nil_credentials_found(authorizer)
    url = authorizer.get_authorization_url(base_url: OOB_URI)
 puts "-----------------it was nil-----------------------------"
    url
  end

  def self.authorize_part_one
    client_id = Google::Auth::ClientId.new(ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'])
    token_store =  Google::Auth::Stores::RedisTokenStore.new(redis: Redis.new)
    scope = ['https://www.googleapis.com/auth/calendar','https://www.google.com/m8/feeds/','https://www.googleapis.com/auth/plus.login']
    authorizer = Google::Auth::UserAuthorizer.new(client_id, scope, token_store, '/users/auth/google_oauth2/callback')
    user_id = 'rachelumunoz@gmail.com'
    credentials = authorizer.get_credentials(user_id)

    if credentials.nil?
      return @url = self.nil_credentials_found(authorizer)


     #need to get url and redirect to that place
     #need to grab code from authourization

      # url = authorizer.get_authorization_url(base_url: OOB_URI)
      # puts "=============it is nil ================="

      # code = gets



      credentials = authorizer.get_and_store_credentials_from_code(
        user_id: user_id, code: code, base_url: OOB_URI)
    else
      "===============it is not nil===================="
    end
    credentials
  end

  def get_and_store_that_code(authorizer, code, user_id)
    code = gets
    credentials = authorizer.get_and_store_credentials_from_code(
        user_id: user_id, code: code, base_url: OOB_URI)
  end


end
