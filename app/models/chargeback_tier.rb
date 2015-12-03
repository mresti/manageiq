class ChargebackTier < ActiveRecord::Base
  belongs_to :chargeback_rate_detail
  validates_numericality_of :fix_rate, :var_rate
  validates_numericality_of :start, unless: ":start == -Float::INFINITY"
  validates_numericality_of :end, unless: ":end == Float::INFINITY"
end
