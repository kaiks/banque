FactoryGirl.define do
  factory :user do
    name 'Jacques'
    surname  'Dupont'
    birth_date Date.new(1990,01,01)
    city 'Paris'
  end

  # This will use the User class (Admin would have been guessed)
  factory :income_bracket do
    min 0
    max 999
  end

  factory :account do
    bank_code 12345
    sort_code 67890
    rib   44
    number 'A1B2C3D4E50'
  end

  factory :transaction do
    amount 100
  end


end