DATA = {3.hour.ago => {"cpu_usage_rate_average" => 2}}

FactoryGirl.define do
  factory :showback_event do
    data                      DATA
    sequence(:id_obj)         { 1000001 }
    type_obj                  'VM'
    start_time                3.hour.ago
    end_time                  1.hour.ago
    showback_configuration
  end
end
