class Heating < ApplicationRecord
  belongs_to :heating_unit
  belongs_to :query
end
