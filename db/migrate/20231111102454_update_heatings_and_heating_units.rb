class UpdateHeatingsAndHeatingUnits < ActiveRecord::Migration[7.1]
  def change
    # Add 'state' to heating_units
    add_column :heating_units, :state, :string

    # Remove 'state' from heatings
    remove_column :heatings, :state, :string
  end
end
