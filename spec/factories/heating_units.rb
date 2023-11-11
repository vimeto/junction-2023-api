FactoryBot.define do
  factory :heating_unit do
    heating_type { HeatingUnit::HEAT_PUMP }
  end
end
