class Account < ActiveRecord::Base
  belongs_to :user


  validates :number, uniqueness: true
  validates :number, format: {
      with: /[A-z0-9]{11}/,
      message: "Numéro de compte doit comporter 11 caractères (lettres/chiffres)."
  }

end
