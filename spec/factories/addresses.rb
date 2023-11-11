FactoryBot.define do
  factory :address do
    street { SecureRandom.hex(10) }
    city { SecureRandom.hex(10) }
    state { SecureRandom.hex(10) }
    zipcode { SecureRandom.hex(10) }
  end
end
