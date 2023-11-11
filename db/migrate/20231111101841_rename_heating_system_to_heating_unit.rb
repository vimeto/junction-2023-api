class RenameHeatingSystemToHeatingUnit < ActiveRecord::Migration[7.1]
  def change
    rename_table :heating_systems, :heating_units
  end
end
