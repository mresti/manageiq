describe ShowbackEvent do
  let(:showback_event) { FactoryGirl.build(:showback_event) }

  context "validations" do
    it "has a valid factory" do
      expect(showback_event).to be_valid
    end

    it "should validate correct data type" do
      showback_event.data = data
      showback_event.valid?
      expect(showback_event.errors[:data]).not_to eq("can't be blank")
    end

    it "should invalidate incorrect data type" do
      showback_event.data = {}
      showback_event.valid?
      expect(showback_event.errors[:data]).to include "can't be blank"
    end

    it "should ensure presence of data" do
      showback_event.data = "AA"
      showback_event.valid?
      expect(showback_event.errors[:data]).to include "can't be blank"
    end

    it "should ensure presence of data" do
      showback_event.data = nil
      showback_event.valid?
      expect(showback_event.errors[:data]).to include "can't be blank"
    end

    it "should ensure presence of start_time" do
      showback_event.start_time = nil
      showback_event.valid?
      expect(showback_event.errors[:start_time]).to include "can't be blank"
    end

    it "should ensure presence of end_time" do
      showback_event.end_time = nil
      showback_event.valid?
      expect(showback_event.errors[:end_time]).to include "can't be blank"
    end

    it "should ensure presence of id_obj" do
      showback_event.id_obj = nil
      showback_event.valid?
      expect(showback_event.errors[:id_obj]).to include "can't be blank"
    end

    it "should ensure presence of type_obj" do
      showback_event.type_obj = nil
      showback_event.valid?
      expect(showback_event.errors[:type_obj]).to include "can't be blank"
    end
  end

  describe '#validate_format' do
    it 'fails validation if no data' do
      event = ShowbackEvent.new
      expect(event.validate_format).not_to be_nil
    end

    it 'passes validation with correct JSON data' do
      expect(showback_event.validate_format).to be_nil
    end

    it 'fails validations with incorrect JSON data' do
      event = FactoryGirl.build(:showback_event, :data => ":-Invalid:\n-JSON")
      expect(event.validate_format).not_to be_nil
    end
  end
end
