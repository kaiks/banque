class Account < ActiveRecord::Base
  belongs_to :user

  enum status: [:waiting, :active, :closed]


  validates :number, uniqueness: true
  validates :number, format: {
      with: /\A[A-z0-9]{11}\z/,
      message: "Numéro de compte doit comporter 11 caractères (lettres/chiffres)."
  }

  def rib
    rib = ''
    rib += bank_code.to_s.rjust(5, '0')
    rib += sort_code.to_s.rjust(5, '0')
    rib += number
    rib += rib_key.to_s.rjust(2, '0')
  end

end
