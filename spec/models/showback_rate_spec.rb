describe ShowbackRate do
  context "validations" do
    let(:showback_rate) { FactoryGirl.build(:showback_rate) }

    it "has a valid factory" do
      expect(showback_rate).to be_valid
    end

    it "is not valid with a nil fixed_cost" do
      showback_rate.fixed_cost = nil
      showback_rate.valid?
      expect(showback_rate.errors.details[:fixed_cost]).to include(:error=>:blank)
    end

    it "is not valid with a nil variable_cost" do
      showback_rate.variable_cost = nil
      showback_rate.valid?
      expect(showback_rate.errors.details[:variable_cost]).to include(:error=>:blank)
    end

    it 'is valid when assigning fixed_cost' do
      showback_rate.fixed_cost = 15
      showback_rate.valid?
      expect(showback_rate).to be_valid
    end

    it 'is valid when assigning variable_cost' do
      showback_rate.variable_cost = 30
      showback_rate.valid?
      expect(showback_rate).to be_valid
    end

    it 'is not valid if fixed cost is not money' do
      showback_rate.fixed_cost = "cost"
      showback_rate.valid?
      expect(showback_rate.errors.details[:fixed_cost]).to include(:error => :not_a_number, :value => "cost")
    end

    it 'is not valid if variable cost is not money' do
      showback_rate.variable_cost = "cost"
      showback_rate.valid?
      expect(showback_rate.errors.details[:variable_cost]).to include(:error => :not_a_number, :value => "cost")
    end

    it "variable_cost expected to be bigint" do
      expect(FactoryGirl.create(:showback_rate, :variable_cost => 274_525_342_534)).to be_valid
    end

    it "fixed_cost expected to be bigint" do
      expect(FactoryGirl.create(:showback_rate, :fixed_cost => 674_525_342_534)).to be_valid
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
  end
end
