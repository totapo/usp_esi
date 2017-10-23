class Spot < ApplicationRecord
  has_many :routes
  has_many :lines, through: :routes
end
