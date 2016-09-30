class Appointment < ApplicationRecord
  belongs_to :child
  belongs_to :location
  has_one :parent, through: :child, source: :parent # NEED TO MAKE THROUGH WORK
end
