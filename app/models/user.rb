#todo: figure out a primary key
#todo: check date format and do validation if necessary
class User < ActiveRecord::Base
  has_many :accounts
  has_many :transactions, through: :accounts

  belongs_to :income_bracket
  validates :income_bracket,  presence: true
  validates :birth_date,      presence: true

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

  enum title: [:Mr, :Mme, :Mlle]
  validates :title, inclusion: { in: %w(Mr Mme Mlle),
                                 message: "Civilité n'est pas valide"
  }

  validates :password, format: {
      with: /\A[[:alnum:]\-\s]{6,100}\z/,
      message: "Le nom de passe n'est pas vailde."
  }

  validates :country_code, length: { is: 2 }

  def full_name
    name + ' ' + surname
  end

  def name_with_title
    title + ' ' + name + ' ' + surname
  end

  def self.authenticates?(id, password)
    begin
      User.where('password = ?', password).find(id)
    rescue ActiveRecord::RecordNotFound
      return nil
    end

  end
end
