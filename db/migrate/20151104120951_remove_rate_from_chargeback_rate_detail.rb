class RemoveRateFromChargebackRateDetail < ActiveRecord::Migration
  def change
    ChargebackRateDetail.all.to_a.each do |detail|
      if detail.respond_to(:rate)
        cbt = ChargebackTier.create(:start => -Float::INFINITY, :end => Float::INFINITY, :fix_rate => 0.0, :var_rate => detail.rate)
        detail.update_attribute(:chargeback_tiers, [cbt])
      end
    end
    remove_column :chargeback_rate_details, :rate, :string
  end
end
