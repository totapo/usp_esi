class Employee < ApplicationRecord
  validates :name, :cpf, :email, :password, presence: true
end
