class AddCostsAsMonetizeInShowbacksCharges < ActiveRecord::Migration[5.0]
  def up
    add_monetize :showback_charges, :fixed_cost, amount: { null: true, default: nil }
    add_monetize :showback_charges, :variable_cost, amount: { null: true, default: nil }
  end
  def down
    remove_monetize :showback_charges, :fixed_cost
    remove_monetize :showback_charges, :variable_cost
  end
end
