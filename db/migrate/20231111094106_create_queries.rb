class CreateQueries < ActiveRecord::Migration[7.1]
  def change
    create_table :queries do |t|
      t.references :user, null: false, foreign_key: true
      t.text :content
      t.decimal :budget
      t.references :address, null: false, foreign_key: true
      t.integer :occupants
      t.datetime :due_date
      t.references :currentheating, null: false, foreign_key: { to_table: :heatings }

      t.timestamps
    end
  end
end
