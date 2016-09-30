class User < ApplicationRecord
  has_many :children, foreign_key: "parent_id"
end
