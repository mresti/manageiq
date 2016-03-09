class ChargebackTier < ActiveRecord::Base
  belongs_to :chargeback_rate_detail
  validates :fixed_rate, :variable_rate, :start, :end, :numericality => true
  after_initialize :init

  def self.to_float(s)
    if s.to_s.include?("Infinity")
      if s[0] == "-"
        -Float::INFINITY
      else
        Float::INFINITY
      end
    else
      s
    end
  end

  def init
    self.minimum_step ||= 0.0
  end
end
