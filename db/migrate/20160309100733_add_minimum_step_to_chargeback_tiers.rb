class AddMinimumStepToChargebackTiers < ActiveRecord::Migration[5.0]
  def change
    add_column :chargeback_tiers, :minimum_step, :float
  end
end
