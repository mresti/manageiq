class ChangeCostsAsMonetize < ActiveRecord::Migration[5.0]
  def up
    remove_column :showback_charges, :fixed_cost, :decimal
    remove_column :showback_charges, :variable_cost, :decimal
    add_monetize :showback_charges, :fixed_cost, :amount => { :null => true, :default => nil }
    add_monetize :showback_charges, :variable_cost, :amount => { :null => true, :default => nil }
    remove_column :showback_rates, :fixed_cost, :decimal
    remove_column :showback_rates, :variable_cost, :decimal
    add_monetize :showback_rates, :fixed_rate, :amount => { :null => true, :default => nil }
    add_monetize :showback_rates, :variable_rate, :amount => { :null => true, :default => nil }
  end

  def down
    remove_monetize :showback_rates, :variable_rate
    remove_monetize :showback_rates, :fixed_rate
    add_column :showback_rates, :variable_cost, :decimal
    add_column :showback_rates, :fixed_cost, :decimal
    remove_monetize :showback_charges, :variable_cost
    remove_monetize :showback_charges, :fixed_cost
    add_column :showback_charges, :variable_cost, :decimal
    add_column :showback_charges, :fixed_cost, :decimal
  end
end
