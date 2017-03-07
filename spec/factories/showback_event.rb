FactoryGirl.define do
  factory :showback_event do
    id_obj                    1000001
    type_obj                  'VM'
    event_init                3.hour.ago
    event_end                 1.hour.ago
    showback_configuration
  end
end
