class Spot < ApplicationRecord
  has_many :routes, dependent: :delete_all
  has_many :lines, through: :routes
end
