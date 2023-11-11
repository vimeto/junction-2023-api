class HeatingUnit < ApplicationRecord
  PLANNED = "planned"
  INSTALLED = "installed"

  HEAT_PUMP = "heat_pump"

  has_many :heatings
end
