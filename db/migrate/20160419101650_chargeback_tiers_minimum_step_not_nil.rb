class ChargebackTiersMinimumStepNotNil < ActiveRecord::Migration[5.0]
  class ChargebackTier < ActiveRecord::Base
    self.inheritance_column = :_type_disabled # disable STI
  end

  def change
    chargeback_tiers = ChargebackTier.where(:minimum_step => nil)
    chargeback_tiers.update_all(:minimum_step => 0)
  end
end
