class Heating < ApplicationRecord
  belongs_to :heating_unit

  belongs_to :query

  scope :current, -> { where(state: "current") }
  scope :tendered, -> { where(state: 'tendered') }
end
