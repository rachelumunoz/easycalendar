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

  def open?
    self.child == nil
  end

  def set_color
    if !self.open?
      self.color = "red"
    elsif self.activity.id == 1
      self.color = "green"
    elsif self.activity.id == 2
      self.color = "black"
    elsif self.activity.id == 3
      self.color = "darkolivegreen"
    elsif self.activity.id == 4
      self.color = "cornflowerblue"
    elsif self.activity.id == 5
      self.color = "darkviolet"
    else
      self.color = "gray"
    end
    self.save
  end

  def all_day_event?
    self.start == self.start.midnight && self.end == self.end.midnight ? true : false
  end

  # def athlete_full_name
  #   if self.child
  #     return self.child.full_name
  #   else
  #     return "UNBOOKED"
  #   end
  # end

end
