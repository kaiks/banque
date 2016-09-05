#todo: figure out a primary key
#todo: check date format and do validation if necessary
class User < ActiveRecord::Base
  validates :name, format: {
      with: /^[[:alpha:]]+$/,
      message: "Prénom doit comporter que des lettres."
  }
  validates :surname, format: {
      with: /^[[:alpha:]]+$/,
      message: "Nom doit comporter que des lettres."
  }
  validates :city, format: {
      with: /^[[:alpha:]\-\s]+[[:alpha:]]$/,
      message: "Le nom de ville n'est pas vailde."
  }

  validates :title, inclusion: { in: %w(Mr Mme Mlle),
                                 message: "Civilité n'est pas valide"
  }

  validates :password, format: {
      with: /^[[:alpha:]\-\s]+$/,
      message: "Le nom de passe n'est pas vailde."
  }

end
