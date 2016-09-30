class Notification < ApplicationRecord
  belongs_to :appointment
  has_many :messages
end
