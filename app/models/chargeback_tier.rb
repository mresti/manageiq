class ChargebackTier < ActiveRecord::Base
  belongs_to :chargeback_rate_detail
  validates :fix_rate, :var_rate, :start, :end, :numericality => true

  def self.to_float(s)
    if s.to_s.include?("Infinity")
      if s[0] = "-"
        f = -Float::INFINITY
      else
        f = Float::INFINITY
      end
    else
      f = s
    end
  end
end
