class CreateShowbackCosts < ActiveRecord::Migration[5.0]
  def self.up
    create_table :showback_costs do |t|
      t.string :types
      t.string :method
      t.string :calculations
      t.timestamps
    end
  end

  def self.down
    drop_table :showback_costs
  end
end
