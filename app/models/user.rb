class User < ApplicationRecord
  has_many :children, foreign_key: "client_id"
  has_many :lessons, through: :children
  has_many :coach_activities, foreign_key: :coach_id
  has_many :activities, through: :coach_activities
  has_many :client_locations, foreign_key: :client_id
  has_many :appointments
  has_many :coaches, through: :appointments
  has_many :clients, through: :appointments
  has_many :notification_receivers
  has_many :notifications, through: :notification_receivers
  has_many :messages, through: :notifications
end
