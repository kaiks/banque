class IncomeBracket < ActiveRecord::Base
  has_many :users
  validate :does_not_intersect
  validate :has_positive_bracket

  validates :min, numericality: { greater_than_or_equal_to: 0 }
  validates :max, presence: true

  def intersects?
    params = {
        :min => min,
        :max => max
    }
    IncomeBracket.where('min >= :min AND min <= :max OR max >= :min AND max <= :max', params).exists?
  end

  private
  def does_not_intersect
    errors.add :base, 'Il y a une tranche de revenus qui s\'intersecte avec celui-ci' if intersects?
  end

  def has_positive_bracket
    errors.add :max, 'La valeur de max doit être supérieure à min' unless min.nil? or max.nil? or max > min
  end
end
