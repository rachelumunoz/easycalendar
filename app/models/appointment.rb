class Appointment < ApplicationRecord
  belongs_to :child
  belongs_to :location
  has_one :client, through: :child, source: :client # NEED TO MAKE THROUGH WORK
  belongs_to :coach_activity
  has_one :coach, through: :coach_activity

  validates :location, presence: true
  validates :coach_activity, presence: true
  validates :coach, presence: true
end
