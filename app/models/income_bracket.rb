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

  def to_s
    if max == -1
      min.to_s << ' ou plus'
    else
      min.to_s << ' - ' << max.to_s
    end
  end

  private
  def does_not_intersect
    errors.add :base, 'Il y a une tranche de revenus qui s\'intersecte avec celui-ci' if intersects?
  end

  def has_positive_bracket
    errors.add :max, 'La valeur de max doit être supérieure à min' unless
    min.nil? or max.nil? or max > min or open?
  end

  def open?
    max == -1
  end

  def income_bracket_params
    params.require(:income_bracket).permit(:id, :income_bracket_id)
  end
end
