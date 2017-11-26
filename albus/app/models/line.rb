class Line < ApplicationRecord
  has_many :routes, dependent: :delete_all
  has_many :spots, through: :routes
end
