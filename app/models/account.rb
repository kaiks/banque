class Account < ActiveRecord::Base
  after_initialize :set_defaults, if: :new_record?
  belongs_to :user
  has_many :transactions
  enum status: [:waiting, :active, :closed]


  validates :number, uniqueness: true
  validates :number, format: {
      with: /\A[A-Z0-9]{11}\z/,
      message: "Numéro de compte doit comporter 11 caractères (lettres/chiffres)."
  }


  def rib
    rib = ''
    rib += bank_code.to_s.rjust(5, '0')
    rib += sort_code.to_s.rjust(5, '0')
    rib += number
    rib += rib_key.to_s.rjust(2, '0')
  end

  def deletable?
    status == 'waiting' && transactions.count == 0
  end


  def self.generate_number
    /\A[A-Z0-9]{11}\z/.random_example
  end
  private

  def set_defaults
    self.rib_key   ||= self.class.default_rib_key
    self.bank_code ||= self.class.default_bank_code
    self.sort_code ||= self.class.default_sort_code
    self.number    ||= self.class.default_account_number
  end

  def self.default_rib_key
    33
  end

  def self.default_bank_code
    22222
  end

  def self.default_sort_code
    11111
  end

  def self.default_account_number
    generate_number
  end
end
