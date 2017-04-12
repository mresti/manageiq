FactoryGirl.define do
  factory :showback_rate do
    variable_cost              { Money.new(rand(5..20), 'USD') }
    fixed_cost                 { Money.new(rand(5..20), 'USD') }
    calculation                "Duration"
    sequence(:category)        { |n| "CPU#{n}" }
    sequence(:dimension)       { |n| "max_CPU#{n}" }
    sequence(:concept)         { |n| "Concept #{n}" }
    showback_tariff
  end
end
