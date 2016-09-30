class User < ApplicationRecord
  has_many :children, foreign_key: "parent_id"
  has_many :lessons, through: :children
  has_many :coach_activities, foreign_key: :coach_id
  has_many :activities, through: :coach_activities
  has_many :client_locations, foreign_key: :client_id
end
