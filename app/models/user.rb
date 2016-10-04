require 'rest-client'
require 'uri'
require 'net/http'

class User  < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:google_oauth2]
  has_many :children, foreign_key: 'parent_id'
  has_many :clients_children, through: :clients, source: :children

  has_many :appointments, through: :children
  has_many :coached_appointments, through: :coach_activities, source: :appointments

  has_many :coach_activities, foreign_key: :coach_id
  has_many :activities, through: :coach_activities

  has_many :client_locations, foreign_key: :client_id
  has_many :coach_locations, foreign_key: :coach_id

  has_many :coach_invites, through: :coach_activities
  has_many :client_invites, class_name: "Invite", foreign_key: :client_id

  has_many :coaches, through: :coach_invites
  has_many :clients, through: :coach_activities

  has_many :notification_receivers, foreign_key: 'receiver_id'
  has_many :notifications_received, through: :notification_receivers, source: :notification
  has_many :notifications_sent, through: :appointments, source: :notifications

  has_many :messages_received, class_name: "Message", foreign_key: :receiver_id
  has_many :messages_sent, class_name: "Message", foreign_key: :sender_id

  has_many :contacts
  has_many :events
  has_many :calendars

  def self.from_omniauth(auth)
    data = auth.info
    # user = User.where(:email => data["email"]).first

    # unless user
    #     user = User.create(first_name: data["name"],
    #
    #        password: Devise.friendly_token[0,20],
    #        token: access_token.credentials[:token],
    #        expires_at: access_token.credentials[:expires_at]
    #     )
    # end
    # user

    where(email: data.email).first_or_initialize.tap do |user|
      user.password = Devise.friendly_token[0,20]
      user.provider = auth.provider
      user.uid = auth.uid
      user.first_name = auth.info.name
      user.token = auth.credentials.token
      user.expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  def refresh_token_if_expired
    if token_expired?
      response = RestClient.post(
        "accounts.google.com/o/oauth2/token",
        :grant_type => 'refresh_token',
        :refresh_token => self.refresh_token,
        :client_id => ENV['GOOGLE_CLIENT_ID'],
        :client_secret => ENV['GOOGLE_CLIENT_SECRET']
      )
      refresh_hash = JSON.parse(response.body)

      token_will_change!
      expiresat_will_change!

      self.token     = refresh_hash['access_token']
      self.expires_at = DateTime.now + refresh_hash["expires_in"].to_i.seconds

      self.save
      puts 'Saved'
    end
  end



  def token_expired?
    expiry = DateTime.now + ((self.expires_at.to_i) /1000).seconds
    return true if expiry < Time.now
    token_expires_at = expiry
    save if changed?
    false
  end

  def get_google_contacts
    encoded_url = URI.encode("https://www.google.com/m8/feeds/contacts/default/full?max-results=50000")
    uri = URI.parse(encoded_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(uri.request_uri)
    json = JSON.parse(request.read)
    my_contacts = json['feed']['entry']

    my_contacts.each do |contact|
      name = contact['title']['$t'] || nil
      email = contact['gd$email'] ? contact['gd$email'][0]['address'] : nil
      tel = contact['gd$phoneNumber'] ? contact["gd$phoneNumber"][0]["$t"] :  nil
      if contact['link'][1]['type'] == "image/*"
        picture = "#{contact['link'][1]['href']}?access_token=#{token}"
      else
        picture = nil
      end
      contacts.create(name: name, email: email, tel: tel, picture: picture)
    end
  end

  def get_google_calendars
    encoded_url = URI.encode("https://www.googleapis.com/calendar/v3/users/me/calendarList?access_token=#{token}")
    uri = URI.parse(encoded_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    res = Net::HTTP.get(uri)
    json = JSON.parse(res)

    calendars = json["items"]
    calendars.select{|cal| cal['accessRole'] == "owner" }.map do |cal|
      get_events_for_calendar(cal)
    end
    # calendars.select{|cal| puts cal }
  end

def get_events_for_calendar(cal)

  url = "https://www.googleapis.com/calendar/v3/calendars/#{cal["id"]}/events?access_token=#{token}"
  response = open(url)
  json = JSON.parse(response.read)
  my_events = json["items"]

  my_events.each do |event|
    name = event["summary"] || "no name"
    creator = event["creator"] ? event["creator"]["email"] : nil
    start = event["start"] ? event["start"]["dateTime"] : nil
    status = event["status"] || nil
    link = event["htmlLink"] || nil
    calendar = cal["summary"] || nil

    self.events.new(name: name,
                  creator: creator,
                  status: status,
                  start: start,
                  link: link,
                  calendar: calendar
                  )
  end
end

  # def new_event

  # end

  # def calendar
  #   self.calendar
  # end
  # def full_name
  #   self.first_name + " " + self.last_name
  # end


  # def self.find_for_google_oauth2(oauth, signed_in_resource=nil)
  #   credentials = oauth.credentials
  #   data = oauth.info
  #   puts "=========oauth========="
  #   puts oauth
  #   puts "=======data=========="
  #   puts data
  #   puts "=======email=========="
  #   puts data[:email]
  #   puts "=======credentials=========="
  #   puts credentials
  #   puts "=======uid=========="
  #   puts  oauth.uid
  #   puts "=======resfresh token=========="
  #   # puts self.oauth2_refresh_token

  #   user = User.find_by(uid: oauth.uid)

  #   if user
  #     puts "helllllo"
  #   else
  #    user = User.create(
  #       first_name: data[:first_name],
  #       last_name: data[:family_name],
  #       picture: data[:image],
  #       email: data[:email],
  #       password: Devise.friendly_token[0,20],
  #       token: credentials[:token],
  #       expires_at: credentials[:expires_at],
  #       uid: oauth.uid
  #    )
  #   end
  #   user.get_google_contacts   # Wait for next section
  #   user.get_google_calendars  # Wait for next section
  #   user
  # end

#   def get_google_contacts
#   url = "https://www.google.com/m8/feeds/contacts/default/full?access_token=#{token}&alt=json&max-results=100"
#   response = RestClient.get(url)
#   json = JSON.parse(response.body)
#   my_contacts = json['feed']['entry']

#   my_contacts.each do |contact|
#     name = contact['title']['$t'] || nil
#     email = contact['gd$email'] ? contact['gd$email'][0]['address'] : nil
#     tel = contact['gd$phoneNumber'] ? contact["gd$phoneNumber"][0]["$t"] : nil
#     if contact['link'][1]['type'] == "image/*"
#       picture = "#{contact['link'][1]['href']}?access_token=#{token}"
#     else
#       picture = nil
#     end
#     contacts.create(name: name, email: email, tel: tel, picture: picture)
#   end
# end


#   def get_google_calendars
#     url = "https://www.googleapis.com/calendar/v3/users/me/calendarList?access_token=#{token}"

#     puts "===========get_google_calendars=response=============="
#     puts response = RestClient.get(url)
#     response = RestClient.get(url)
#     json = JSON.parse(response)
#     calendars = json["items"]
#     calendars.each { |cal| get_events_for_calendar(cal) }
#   end

#   def get_events_for_calendar(cal)

#     url = "https://www.googleapis.com/calendar/v3/calendars/#{cal["id"]}/events?access_token=#{token}"
#     puts "=========get_events_for_calendar=response============="
#     puts response = RestClient.get(url)
#     response = RestClient.get(url)
#     json = JSON.parse(response)
#     my_events = json["items"]

#     my_events.each do |event|
#       name = event["summary"] || "no name"
#       creator = event["creator"] ? event["creator"]["email"] : nil
#       start = event["start"] ? event["start"]["dateTime"] : nil
#       status = event["status"] || nil
#       link = event["htmlLink"] || nil
#       calendar = cal["summary"] || nil

#       events.create(name: name,
#                     creator: creator,
#                     status: status,
#                     start: start,
#                     link: link,
#                     calendar: calendar
#                     )
#     end

#   end

end
