class CreateQueries < ActiveRecord::Migration[7.1]
  def change
    create_table :queries do |t|
      t.references :user, null: false, foreign_key: true
      t.text :content
      t.string :name
      t.decimal :budget
      t.references :address, null: false, foreign_key: true
      t.integer :occupants
      t.datetime :due_date
      t.text :summary
      t.decimal :houseSqm

      t.timestamps
    end
  end
end
