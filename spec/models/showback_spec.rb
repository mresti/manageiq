describe Showback do
  context "validations" do
    let(:showback) { FactoryGirl.build(:showback) }

    it "has a valid factory" do
      expect(showback).to be_valid
    end

    it "should ensure presence of data" do
      showback.data = nil
      showback.valid?
      expect(showback.errors[:data]).to include "can't be blank"
    end

    it "should invalidate incorrect data type" do
      showback.data = {}
      showback.valid?
      expect(showback.errors[:data]).to include "can't be blank"
    end

    it "should ensure presence of event_init" do
      showback.event_init = nil
      showback.valid?
      expect(showback.errors[:event_init]).to include "can't be blank"
    end

    it "should ensure presence of event_end" do
      showback.event_end = nil
      showback.valid?
      expect(showback.errors[:event_end]).to include "can't be blank"
    end

    it "should ensure presence of id_obj" do
      showback.id_obj = nil
      showback.valid?
      expect(showback.errors[:id_obj]).to include "can't be blank"
    end

    it "should ensure presence of type_obj" do
      showback.type_obj = nil
      showback.valid?
      expect(showback.errors[:type_obj]).to include "can't be blank"
    end
  end
end
