class AddHeatingUnitIdToHeatings < ActiveRecord::Migration[7.1]
  def change
    add_reference :heatings, :heating_unit, null: false, foreign_key: true
  end
end
