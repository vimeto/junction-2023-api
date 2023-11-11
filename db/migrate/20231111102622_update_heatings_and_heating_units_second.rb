class UpdateHeatingsAndHeatingUnitsSecond < ActiveRecord::Migration[7.1]
  def change
    remove_column :heating_units, :percentage

    # Remove 'state' from heatings
    add_column :heatings, :percentage, :decimal, precision: 10
  end
end
