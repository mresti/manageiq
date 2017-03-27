class AddCostsAsMonetizeInShowbacksCharges < ActiveRecord::Migration[5.0]
  def change
    change_table :showback_charges do |t|
      t.monetize :fixed_cost
      t.monetize :variable_cost
    end
  end
end
