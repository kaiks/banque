#todo: figure out a primary key
#todo: check date format and do validation if necessary
class User < ActiveRecord::Base
  has_many :accounts
  belongs_to :income_bracket

  validates :name, format: {
      with: /\A[[:alpha:]]+\z/,
      message: "Prénom doit comporter que des lettres."
  }
  validates :surname, format: {
      with: /\A[[:alpha:]]+\z/,
      message: "Nom doit comporter que des lettres."
  }
  validates :city, format: {
      with: /\A[[:alpha:]\-\s]+[[:alpha:]]\z/,
      message: "Le nom de ville n'est pas vailde."
  }

  validates :title, inclusion: { in: %w(Mr Mme Mlle),
                                 message: "Civilité n'est pas valide"
  }

  validates :password, format: {
      with: /\A[[:alnum:]\-\s]{6,100}\z/,
      message: "Le nom de passe n'est pas vailde."
  }

end
