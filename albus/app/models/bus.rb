class Bus < ApplicationRecord
  belongs_to :driver, optional: true
end
