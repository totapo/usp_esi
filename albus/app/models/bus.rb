class Bus < ApplicationRecord
  belongs_to :driver, optional: true
  validates :model, :plate, :nSeats, presence: true
end
