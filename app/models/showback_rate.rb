class ShowbackRate < ApplicationRecord
  belongs_to :showback_tariff, :inverse_of => :showback_rates
  validates :fixed_cost,     :presence => true
  validates :variable_cost,  :presence => true
  validates :calculation,    :presence => true
  validates :category,       :presence => true
  validates :dimension,      :presence => true
  monetize :fixed_cost_cents, :with_model_currency => :fixed_cost_currency, :allow_nil => true
  monetize :variable_cost_cents, :with_model_currency => :variable_cost_currency, :allow_nil => true
end
