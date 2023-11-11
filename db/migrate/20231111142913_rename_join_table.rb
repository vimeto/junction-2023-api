class RenameJoinTable < ActiveRecord::Migration[7.1]
  def change
    create_table :tendering_heatings, id: false do |t|
      t.references :query, null: false, foreign_key: true
      t.references :heating, null: false, foreign_key: true
      t.primary_key [:query_id, :heating_id]
    end
  end
end
