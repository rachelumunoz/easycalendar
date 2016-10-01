class Child < ApplicationRecord
  belongs_to :client, class_name: "User"
  has_many :appointments

  validates :client, presence: true
end
