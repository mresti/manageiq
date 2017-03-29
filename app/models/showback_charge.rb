class ShowbackCharge < ApplicationRecord
  belongs_to :showback_bucket
  belongs_to :showback_event
  validates :showback_bucket, :presence => true, :allow_nil => false
  validates :showback_event, :presence => true, :allow_nil => false
  monetize :fixed_cost_cents, :with_model_currency => :fixed_cost_currency, :allow_nil => true
  monetize :variable_cost_cents, :with_model_currency => :variable_cost_currency, :allow_nil => true
end
