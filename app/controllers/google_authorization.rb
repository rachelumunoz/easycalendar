require 'googleauth'
require 'googleauth/stores/redis_token_store'
require 'google/apis/calendar_v3'
require 'googleauth/stores/file_token_store'
require 'dotenv'
require 'google/api_client/client_secrets'

module GoogleAuthorization
  OOB_URI = "http://localhost:3000/users/auth/google_oauth2/callback"



  def self.authorize_part_one
    client_id = Google::Auth::ClientId.new(ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'])
    token_store =  Google::Auth::Stores::RedisTokenStore.new(redis: Redis.new)
    scope = ['https://www.googleapis.com/auth/calendar','https://www.google.com/m8/feeds/','https://www.googleapis.com/auth/plus.login']
    authorizer = Google::Auth::UserAuthorizer.new(client_id, scope, token_store, '/users/auth/google_oauth2/callback')
    user_id = 'default'
    credentials = authorizer.get_credentials(user_id)
    if credentials.nil?
      #do stuff to get authorization
      #have link
      url = authorizer.get_authorization_url(base_url: OOB_URI)
       return @return = url
      puts "=============it is nil ================="
    # end


      # puts "Open the following URL in the browser and enter the " +
           # "resulting code after authorization"
      # puts url
      # code = gets
      # credentials = authorizer.get_and_store_credentials_from_code(
    #     user_id: user_id, code: code , base_url: OOB_URI)
    else
      "===============it is not nil===================="
      credentials
    end
    # credentials
    # puts "==========it got to credentials======================="
  end

end
