class CreateCompanies < ActiveRecord::Migration[7.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :email
      t.references :address, null: true, foreign_key: true

      t.timestamps
    end
  end
end
