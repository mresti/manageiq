class ChargebackTier < ActiveRecord::Base
  belongs_to :chargeback_rate_detail
  validates :fix_rate, :var_rate, :start, :end, :numericality => true
end
