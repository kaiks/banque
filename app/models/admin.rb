class Admin < ActiveRecord::Base
  has_secure_password
  has_many :transactions
  validates :username, format: {
      with: /\A[[:alpha:]]+\z/,
      message: "Nom d'utilisateur doit comporter que des lettres."
  }
  validates :name, format: {
      with: /\A[[:alpha:]]+\z/,
      message: "Prénom doit comporter que des lettres."
  }
  validates :surname, format: {
      with: /\A[[:alpha:]]+\z/,
      message: "Nom doit comporter que des lettres."
  }, allow_blank: true

  validates :password, format: {
      with: /\A[[:alnum:]\-\s]{6,100}\z/,
      message: "Le nom de passe n'est pas vailde."
  }
  validates :username, uniqueness: true

  def self.authenticates?(username, password)
    begin
      Admin.find_by_username(username).authenticate(password)
    rescue NoMethodError
      return nil
    end
  end
end
