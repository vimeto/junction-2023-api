class CreateHeatings < ActiveRecord::Migration[7.1]
  def change
    create_table :heatings do |t|
      t.string :heating_type
      t.decimal :energy
      t.decimal :cost
      t.string :state

      t.timestamps
    end
  end
end
