class IntersectionValidator < ActiveModel::Validator
  def validate(record)

  end
end

class IncomeBracket < ActiveRecord::Base
  has_many :users
  validate :does_not_intersect

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
end
