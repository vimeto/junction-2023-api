class CreateQuotations < ActiveRecord::Migration[7.1]
  def change
    create_table :quotations do |t|
      t.references :query, null: false, foreign_key: true

      t.timestamps
    end
  end
end
