class RemoveCostsFromShowbacksCharges < ActiveRecord::Migration[5.0]
  def change
    remove_column :showback_charges, :fixed_cost, :money
    remove_column :showback_charges, :variable_cost, :money
  end
end
