class ShowbackRate < ApplicationRecord
  belongs_to :showback_tariff, :inverse_of => :showback_rates
  validates :fixed_rate,     :presence => true
  validates :variable_rate,  :presence => true
  validates :calculation,    :presence => true
  validates :category,       :presence => true
  validates :dimension,      :presence => true
  monetize :fixed_rate_cents, :with_model_currency => :fixed_rate_currency, :allow_nil => true
  monetize :variable_rate_cents, :with_model_currency => :variable_rate_currency, :allow_nil => true
end
