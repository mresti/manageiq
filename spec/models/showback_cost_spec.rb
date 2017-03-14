describe ShowbackCost do
  context "validations" do
    let(:showback_cost) { FactoryGirl.build(:showback_cost) }

    it "has a valid factory" do
      expect(showback_cost).to be_valid
    end

    it "should ensure presence of types" do
      showback_cost.types = nil
      showback_cost.valid?
      expect(showback_cost.errors[:types]).to include "can't be blank"
    end

    it "should ensure presence of method" do
      showback_cost.operations = nil
      showback_cost.valid?
      expect(showback_cost.errors[:operations]).to include "can't be blank"
    end

    it "should ensure presence of calculations" do
      showback_cost.operations = nil
      showback_cost.valid?
      expect(showback_cost.errors[:operations]).to include "can't be blank"
    end
  end
end
