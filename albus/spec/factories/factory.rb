FactoryBot.define do
  factory :employee do
    name "Name"
    password "1234"
    sequence :email do |n|
      "email@email#{n}.com"
    end
    telephone "12345678"
    cpf "12312332123"
  end

  factory :driver do
    name "Name"
    sequence :email do |n|
      "email@email#{n}.com"
    end
    telephone "12345678"
    cpf "12312332123"
  end

  factory :bus do
    sequence :plate do |n|
      "ASR-#{n}"
    end
    model "modelo"
    sequence :nSeats do |n|
      n
    end
  end

  # This will use the User class (Admin would have been guessed)
  #factory :admin, class: User do
  #  first_name "Admin"
  #  last_name  "User"
  #  admin      true
  #end
end
