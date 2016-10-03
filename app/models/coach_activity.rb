class CoachActivity < ApplicationRecord
  belongs_to :coach, class_name: "User"
  belongs_to :activity
  has_many :appointments

  validates :coach, presence: true
  validates :activity, presence: true
end
