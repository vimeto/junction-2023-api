class CreateQueryNotifications < ActiveRecord::Migration[7.1]
  def change
    create_table :query_notifications do |t|
      t.references :query, null: false, foreign_key: true
      t.integer :status, default: 0

      t.string :content

      t.timestamps
    end
  end
end
