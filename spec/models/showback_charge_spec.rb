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

  it 'is valid with nil fixed_cost' do
    charge.fixed_cost = nil
    charge.valid?
    expect(charge).to be_valid
  end

  it 'is valid with nil variable_cost' do
    charge.variable_cost = nil
    charge.valid?
    expect(charge).to be_valid
  end

  it 'is valid when assigning fixed_costs' do
    charge.fixed_cost = 15
    charge.valid?
    expect(charge).to be_valid
  end

  it 'is valid when assigning variable_cost' do
    charge.variable_cost = 30
    charge.valid?
    expect(charge).to be_valid
  end

  it 'is not valid if fixed cost is not money' do
    charge.fixed_cost = 'cost'
    charge.valid?
    expect(charge.errors.details[:fixed_cost]).to include(:error => :not_a_number, :value => "cost")
  end

  it 'is not valid if variable cost is not money' do
    charge.variable_cost = 'cost'
    charge.valid?
    expect(charge.errors.details[:variable_cost]).to include(:error => :not_a_number, :value => "cost")
  end

  it "fixed_cost expected to be Money" do
    expect(FactoryGirl.create(:showback_charge, :fixed_cost => Money.new("5.9234892348923"))).to be_valid
    expect(ShowbackCharge).to monetize(:fixed_cost)
  end

  it "variable_cost expected to be Money" do
    expect(FactoryGirl.create(:showback_charge, :variable_cost => Money.new("71.2348723487"))).to be_valid
    expect(ShowbackCharge).to monetize(:variable_cost)
  end

  it 'correctly assigns Integer objects to the fixed_costs' do
    charge.fixed_cost = 33
    expect(charge.fixed_cost).to eq Money.new(3300, 'USD')
  end

  it 'correctly assigns String objects to the fixed_costs' do
    charge.fixed_cost = "12"
    expect(charge.fixed_cost).to eq Money.new(1200, 'USD')
  end

  it 'correctly assigns Integer objects to the fixed_cost_cents' do
    charge.fixed_cost_cents = 69
    expect(charge.fixed_cost).to eq Money.new(69, 'USD')
  end

  it 'correctly assigns Money objects to the fixed_costs' do
    charge.fixed_cost = Money.new(81, 'USD')
    expect(charge.fixed_cost).to eq Money.new(81, 'USD')
  end

  it 'correctly assigns Integer objects to the variable_cost' do
    charge.variable_cost = 33
    expect(charge.variable_cost).to eq Money.new(3300, 'USD')
  end

  it 'correctly assigns String objects to the variable_cost' do
    charge.variable_cost = "12"
    expect(charge.variable_cost).to eq Money.new(1200, 'USD')
  end

  it 'correctly assigns Integer objects to the variable_cost_cents' do
    charge.variable_cost_cents = 69
    expect(charge.variable_cost).to eq Money.new(69, 'USD')
  end

  it 'correctly assigns Money objects to the variable_cost' do
    charge.variable_cost = Money.new(81, 'USD')
    expect(charge.variable_cost).to eq Money.new(81, 'USD')
  end
end
