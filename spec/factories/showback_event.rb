require 'faker'

START_TIME = Faker::Time.between(Time.current - 1, Time.current)
END_TIME = Faker::Time.between(START_TIME, Time.current)
EVENT_TIME = Faker::Time.between(START_TIME, END_TIME)
DATA = { EVENT_TIME.to_datetime => {"cpu_usage_rate_average" => 2} }.freeze

FactoryGirl.define do
  factory :showback_event do
    data                      DATA
    sequence(:id_obj)         { |n| 100_000 + n }
    type_obj                  'VM'
    start_time                START_TIME
    end_time                  END_TIME
    showback_configuration
  end
end
