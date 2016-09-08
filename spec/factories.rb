FactoryGirl.define do
  factory :income_bracket do
    min 0
    max 999
  end

  factory :user do
    name 'Jacques'
    surname  'Dupont'
    income_bracket
    birth_date Date.new(1990,01,01)
    city 'Paris'
    title 'Mr'
    password 'abc123456'
  end

  factory :account do
    bank_code 1
    sort_code 678
    rib_key   44
    number 'A1B2C3D4E50'
  end

  factory :admin do
    username 'admin'
    name 'Superuser'
    password 'admin123'
  end

  factory :transaction do
    account
    amount 100

    factory :accepted_transaction do
      admin
      managed_at DateTime.now
      status :accepted
    end
  end


end