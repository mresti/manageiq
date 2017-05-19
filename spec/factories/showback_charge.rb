FactoryGirl.define do
  factory :showback_charge do
    showback_bucket
    showback_event
    cost 0
  end
end
