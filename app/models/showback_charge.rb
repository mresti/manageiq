class ShowbackCharge < ApplicationRecord
  belongs_to :showback_bucket
  belongs_to :showback_event
  validates :showback_bucket, :presence => true, :allow_nil => false
  validates :showback_event, :presence => true, :allow_nil => false
  monetize :fixed_cost_cents, :with_model_currency => :fixed_cost_currency, :allow_nil => true
  monetize :variable_cost_cents, :with_model_currency => :variable_cost_currency, :allow_nil => true
  validate :fixed_cost_big_decimal, :variable_cost_big_decimal

  def fixed_cost_big_decimal
    unless fixed_cost.nil?
      errors.add(:fixed_cost, "must be of class money") unless fixed_cost.class == Money
    end
  end

  def variable_cost_big_decimal
    unless variable_cost.nil?
      errors.add(:variable_cost, "must be of class money") unless variable_cost.class == Money
    end
  end
end
