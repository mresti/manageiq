class CreateChargebackTiers < ActiveRecord::Migration
  def change
    create_table :chargeback_tiers do |t|
      t.bigint :chargeback_rate_detail_id
      t.float :start
      t.float :end
      t.float :fix_rate
      t.float :var_rate

      t.timestamp :null => false
    end
  end
end
