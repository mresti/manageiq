describe ShowbackRate do
  context "validations" do
    let(:showback_rate) { FactoryGirl.build(:showback_rate) }

    it "has a valid factory" do
      expect(showback_rate).to be_valid
    end

    it "is not valid with a nil fixed_rate" do
      showback_rate.fixed_rate_cents = nil
      showback_rate.valid?
      expect(showback_rate.errors.details[:fixed_rate]).to include(:error => :not_a_number, :value => '')
    end

    it "is not valid with a nil variable_rate" do
      showback_rate.variable_rate_cents = nil
      showback_rate.valid?
      expect(showback_rate.errors.details[:variable_rate]).to include(:error => :not_a_number, :value => '')
    end

    it "is  valid with a nil concept" do
      showback_rate.concept = nil
      showback_rate.valid?
      expect(showback_rate).to be_valid
    end

    it "is not valid with a nil calculation" do
      showback_rate.calculation = nil
      showback_rate.valid?
      expect(showback_rate.errors.details[:calculation]).to include(:error=>:blank)
    end

    it "is is valid with a nil concept" do
      showback_rate.concept = nil
      showback_rate.valid?
      expect(showback_rate).to be_valid
    end

    it "is not valid with a nil dimension" do
      showback_rate.dimension = nil
      showback_rate.valid?
      expect(showback_rate.errors.details[:dimension]).to include(:error=>:blank)
    end

    it 'is valid when assigning fixed_rate' do
      showback_rate.fixed_rate = 15
      showback_rate.valid?
      expect(showback_rate).to be_valid
    end

    it 'is valid when assigning variable_rate' do
      showback_rate.variable_rate = 30
      showback_rate.valid?
      expect(showback_rate).to be_valid
    end

    it 'is not valid if fixed rate is not money' do
      showback_rate.fixed_rate = 'cost'
      showback_rate.valid?
      expect(showback_rate.errors.details[:fixed_rate]).to include(:error => :not_a_number, :value => "cost")
    end

    it 'is not valid if variable rate is not money' do
      showback_rate.variable_rate = 'cost'
      showback_rate.valid?
      expect(showback_rate.errors.details[:variable_rate]).to include(:error => :not_a_number, :value => "cost")
    end

    it "fixed_rate expected to be Money" do
      expect(FactoryGirl.create(:showback_rate, :fixed_rate => Money.new("2.5634525342534"))).to be_valid
      expect(ShowbackRate).to monetize(:fixed_rate)
    end

    it "variable_rate expected to be Money" do
      expect(FactoryGirl.create(:showback_rate, :variable_rate => Money.new("67.4525342534"))).to be_valid
      expect(ShowbackRate).to monetize(:variable_rate)
    end

    it 'correctly assigns Integer objects to the fixed_rate' do
      showback_rate.fixed_rate = 15
      expect(showback_rate.fixed_rate).to eq Money.new(1500, 'USD')
    end

    it 'correctly assigns String objects to the fixed_rate' do
      showback_rate.fixed_rate = "23"
      expect(showback_rate.fixed_rate).to eq Money.new(2300, 'USD')
    end

    it 'correctly assigns Integer objects to the fixed_rate_cents' do
      showback_rate.fixed_rate_cents = 66
      expect(showback_rate.fixed_rate).to eq Money.new(66, 'USD')
    end

    it 'correctly assigns Money objects to the fixed_rate' do
      showback_rate.fixed_rate = Money.new(82, 'USD')
      expect(showback_rate.fixed_rate).to eq Money.new(82, 'USD')
    end

    it 'correctly assigns Integer objects to the variable_rate' do
      showback_rate.variable_rate = 15
      expect(showback_rate.variable_rate).to eq Money.new(1500, 'USD')
    end

    it 'correctly assigns String objects to the variable_rate' do
      showback_rate.variable_rate = "23"
      expect(showback_rate.variable_rate).to eq Money.new(2300, 'USD')
    end

    it 'correctly assigns Integer objects to the variable_rate_cents' do
      showback_rate.variable_rate_cents = 66
      expect(showback_rate.variable_rate).to eq Money.new(66, 'USD')
    end

    it 'correctly assigns Money objects to the variable_rate' do
      showback_rate.variable_rate = Money.new(82, 'USD')
      expect(showback_rate.variable_rate).to eq Money.new(82, 'USD')
    end
  end
end
