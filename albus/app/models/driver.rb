class Driver < ApplicationRecord
  has_one :bus
  validates :name, :cpf, :email, presence: true
end
