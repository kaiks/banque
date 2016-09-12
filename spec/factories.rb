FactoryGirl.define do
  factory :income_bracket do
    min 0
    max 999

    factory :open_bracket do
      min 1000
      max -1
    end
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
    number { Account.generate_number }
    factory :closed_account do
      status :closed
    end

    factory :active_account do
      status :active
    end
  end

  factory :admin do
    username 'admin'
    name 'Superuser'
    password 'admin123'
  end

  factory :transaction do
    association :account, factory: :active_account
    amount 100

    factory :accepted_transaction do
      admin
      managed_at DateTime.now
      status :accepted

      factory :refused_transaction do
        status :refused
      end
    end
  end


end