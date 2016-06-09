class AddCostMethodToChargebackRateDetail < ActiveRecord::Migration[5.0]
  def change
    add_column :chargeback_rate_details, :cost_method, :string    
  end
end
