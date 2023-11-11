class UpdateHeatingsAndHeatingUnitsThird < ActiveRecord::Migration[7.1]
  def change
    remove_column :heatings, :heating_type

    # Remove 'state' from heatings
    add_column :heating_units, :heating_type, :string
  end
end
