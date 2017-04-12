describe ShowbackRate do
  context "validations" do
    let(:showback_rate) { FactoryGirl.build(:showback_rate) }

    it "has a valid factory" do
      expect(showback_rate).to be_valid
    end

    it "is not valid with a nil fixed_rate" do
      showback_rate.fixed_rate = nil
      showback_rate.valid?
      expect(showback_rate.errors.details[:fixed_rate]).to include(:error=>:blank)
    end

    it "is not valid with a nil variable_rate" do
      showback_rate.variable_rate = nil
      showback_rate.valid?
      expect(showback_rate.errors.details[:variable_rate]).to include(:error=>:blank)
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
      showback_rate.fixed_rate = "cost"
      showback_rate.valid?
      expect(showback_rate.errors.details[:fixed_rate]).to include(:error => :not_a_number, :value => "cost")
    end

    it 'is not valid if variable rate is not money' do
      showback_rate.variable_rate = "cost"
      showback_rate.valid?
      expect(showback_rate.errors.details[:variable_rate]).to include(:error => :not_a_number, :value => "cost")
    end

    it "variable_rate expected to be bigint" do
      expect(FactoryGirl.create(:showback_rate, :variable_rate => 274_525_342_534)).to be_valid
    end

    it "fixed_rate expected to be bigint" do
      expect(FactoryGirl.create(:showback_rate, :fixed_rate => 674_525_342_534)).to be_valid
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
