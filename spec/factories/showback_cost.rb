FactoryGirl.define do
  factory :showback_cost do
    types              "CPU"
    method             "average"
    calculations       "cpu_used * 30 / 31"
  end
end
