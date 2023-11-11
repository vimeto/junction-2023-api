class CreateHeatings < ActiveRecord::Migration[7.1]
  def change
    create_table :heating_units do |t|
      t.string :name
      t.string :heating_type

      t.timestamps
    end

    create_table :heatings do |t|
      t.decimal :energy
      t.decimal :cost
      t.string :state
      t.decimal :percentage
      t.references :heating_unit, null: false, foreign_key: true
      t.references :query, null: false, foreign_key: true

      t.timestamps
    end
  end
end
