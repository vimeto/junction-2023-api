class RemoveCurrentHeatingFromQueries < ActiveRecord::Migration[7.1]
  def change
    remove_column :queries, :currentheating_id, :bigint
  end
end
