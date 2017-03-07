FactoryGirl.define do
  factory :showback do
    data                      { { 3.hour.ago => {"cpu_usage_rate_average" => 2} } }
    id_obj                    1000001
    type_obj                  'VM'
    event_init                3.hour.ago
    event_end                 1.hour.ago
    showback_configuration
  end
end
