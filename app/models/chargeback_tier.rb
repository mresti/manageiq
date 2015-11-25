class ChargebackTier < ActiveRecord::Base
  belongs_to :chargeback_rate_detail
  validates_numericality_of :start, :end, :fix_rate, :var_rate
end
