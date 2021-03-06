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

  has_many :coach_invites, through: :coach_activities, source: :invites
  has_many :client_invites, class_name: "Invite", foreign_key: :client_id

  has_many :coaches, through: :client_invites
  has_many :clients, through: :coach_activities

  has_many :notification_receivers, foreign_key: 'receiver_id'
  has_many :notifications_received, through: :notification_receivers, source: :notification
  has_many :notifications_sent, through: :appointments, source: :notifications

  has_many :messages_received, class_name: "Message", foreign_key: :receiver_id
  has_many :messages_sent, class_name: "Message", foreign_key: :sender_id

  has_many :contacts
  has_many :events
  has_many :calendars

  default_scope { where("status != 'Inactive'") }

  def self.from_omniauth(auth)
    data = auth.info
    where(email: data.email).first_or_initialize.tap do |user|
      user.password = Devise.friendly_token[0,20]
      user.provider = auth.provider
      user.uid = auth.uid
      user.refresh_token = auth.credentials.refresh_token
      user.first_name = auth.info.name
      user.token = auth.credentials.token
      user.expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  def events_to_appointments
    appointment_count = coached_appointments.where(google_event_id: events.pluck(:google_event_id)).pluck(:google_event_id).uniq.size
    return if appointment_count >= events.pluck(:google_event_id).uniq.size
    self.events.each do |event|
      appointment = Appointment.find_or_initialize_by(google_event_id: event.google_event_id)
      appointment.coach_activity = self.coach_activities.first || CoachActivity.find_or_initialize_by(activity: Activity.first, coach: self)
      appointment.location = Location.find_by(address: event.location) || Location.find_or_initialize_by(name: "Unknown", address: "Unknown")
      appointment.start = event.start
      appointment.end = event.end_time
      appointment.coach = self
      appointment.save!
    end
  end

  # This is ark's way of associating a canceled appointment
  # with a notification receiver so that they can reply with
  # a 'Yes' and get it.  If we want to be more precise,
  # to guard against the possibility of receiving multiple
  # notifications but only being able to reply 'Yes' to the
  # most recent, we will need to associate the canceled appt's
  # id and require the user to enter something like 'Yes 123'
  # or 'Book 123' for appt_id 123
  def most_recent_notification_received
    notifications_received.order(created_at: :desc).first
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
  end

  def get_events_for_calendar(cal)
    url = "https://www.googleapis.com/calendar/v3/calendars/#{cal["id"]}/events?access_token=#{token}"
    response = open(url)
    json = JSON.parse(response.read)
    my_events = json["items"]
    existing_event_count = self.events.where(google_event_id: my_events.map{|event| event["id"] }).size
    return if existing_event_count >= my_events.length
    my_events.each do |event|
      summary = event["summary"] || "no name"
      start = event["start"] ? event["start"]["dateTime"] : nil
      end_time = event["end"] ? event["end"]["dateTime"] : nil
      link = event["htmlLink"] || nil
      status = event["status"] || nil
      google_event_id = event["id"]
      creator = event["creator"] ? event["creator"]["email"] : nil
      location = event["location"] || nil
      description = event["description"] || nil
      calendar = cal["summary"] || nil

      # need a location check when converting to appt
      event = self.events.find_or_create_by(google_event_id: google_event_id)
      event.update(summary: summary,
                    creator: creator,
                    status: status,
                    start: start,
                    end_time: end_time,
                    link: link,
                    google_event_id: google_event_id,
                    location: location,
                    description: description,
                    calendar: calendar
                    )
    end
  end

  def full_name
    #self.first_name + " " + self.last_name
    "helloworld"
  end
end


  # def get_google_contacts
  #   encoded_url = URI.encode("https://www.google.com/m8/feeds/contacts/default/full?max-results=50000")
  #   uri = URI.parse(encoded_url)
  #   http = Net::HTTP.new(uri.host, uri.port)
  #   http.use_ssl = true
  #   http.verify_mode = OpenSSL::SSL::VERIFY_NONE

  #   request = Net::HTTP::Get.new(uri.request_uri)
  #   json = JSON.parse(request.read)
  #   my_contacts = json['feed']['entry']

  #   my_contacts.each do |contact|
  #     name = contact['title']['$t'] || nil
  #     email = contact['gd$email'] ? contact['gd$email'][0]['address'] : nil
  #     tel = contact['gd$phoneNumber'] ? contact["gd$phoneNumber"][0]["$t"] :  nil
  #     if contact['link'][1]['type'] == "image/*"
  #       picture = "#{contact['link'][1]['href']}?access_token=#{token}"
  #     else
  #       picture = nil
  #     end
  #     contacts.create!(name: name, email: email, tel: tel, picture: picture)
  #   end
  # end
  #
