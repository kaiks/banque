class Account < ActiveRecord::Base
  after_initialize :set_defaults, if: :new_record?
  belongs_to :user
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

  private

  def set_defaults
    self.rib_key   ||= default_rib_key
    self.bank_code ||= default_bank_code
    self.sort_code ||= default_sort_code
    self.number    ||= default_account_number
  end

  def default_rib_key
    33
  end

  def default_bank_code
    22222
  end

  def default_sort_code
    11111
  end

  def default_account_number
    generate_number
  end

  def generate_number
    /\A[A-Z0-9]{11}\z/.random_example
  end
end
