class CreateHeatingSystems < ActiveRecord::Migration[7.1]
  def change
    create_table :heating_systems do |t|
      t.decimal :percentage

      t.timestamps
    end
  end
end
