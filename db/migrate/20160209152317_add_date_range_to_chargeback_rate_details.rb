class AddDateRangeToChargebackRateDetails < ActiveRecord::Migration
  def change
    add_column :chargeback_rate_details, :start_date, :date
    add_column :chargeback_rate_details, :end_date, :date
  end
end
