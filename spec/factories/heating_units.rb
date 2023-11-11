FactoryBot.define do
  factory :heating_unit do
    state { HeatingUnit::PLANNED }
    heating_type { HeatingUnit::HEAT_PUMP }
  end
end
