class Bus < ApplicationRecord
  belongs_to :driver, optional: true
  belongs_to :line, optional: true
  has_many :lines
  validates :model, :plate, :nSeats, presence: true
end
