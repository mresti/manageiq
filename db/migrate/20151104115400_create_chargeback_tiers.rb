class CreateChargebackTiers < ActiveRecord::Migration
  def change
    create_table :chargeback_tiers do |t|
      t.bigint :chargeback_rate_id
      t.float :start
      t.float :end
      t.float :fix_rate
      t.float :var_rate

      t.timestamps null: false
    end
  end
end
