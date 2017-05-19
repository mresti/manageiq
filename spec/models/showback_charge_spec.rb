require 'rails_helper'

RSpec.describe ShowbackCharge, :type => :model do
  let(:charge) { FactoryGirl.build(:showback_charge) }

  it 'has a valid factory' do
    expect(charge).to be_valid
  end

  it 'is not valid without a bucket' do
    charge.showback_bucket = nil
    charge.valid?
    expect(charge.errors.details[:showback_bucket]). to include(:error => :blank)
  end

  it 'is not valid without an event' do
    charge.showback_event = nil
    charge.valid?
    expect(charge.errors.details[:showback_event]). to include(:error => :blank)
  end

  pending 'is not valid with nil cost'

  it 'is valid with cost' do
    charge.cost = nil
    charge.valid?
    expect(charge).to be_valid
  end


  it 'is valid when assigning fixed_costs' do
    charge.cost = 15
    charge.valid?
    expect(charge).to be_valid
  end

  pending 'is not valid if cost is not money'

end
