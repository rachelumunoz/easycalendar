class Appointment < ApplicationRecord
  belongs_to :child
  belongs_to :location
  # belongs_to :parent, through: :child
end
