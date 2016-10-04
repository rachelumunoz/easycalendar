class Appointment < ApplicationRecord
  belongs_to :child, optional: true
  belongs_to :location
  has_one :client, through: :child, source: :parent
  belongs_to :coach_activity
  #test
  has_one :activity, through: :coach_activity, foreign_key: :coach_activity
  has_one :coach, through: :coach_activity
  has_many :notifications

  validates :location, presence: true
  validates :coach_activity, presence: true
  validates :coach, presence: true
  attr_accessor :date_range

  def all_day_event?
    self.start == self.start.midnight && self.end == self.end.midnight ? true : false
  end

end
