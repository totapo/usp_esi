class Line < ApplicationRecord
  has_many :routes
  has_many :spots, through: :routes
end
