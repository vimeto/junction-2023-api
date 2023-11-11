class CreateJoinTableQueryTenderingHeatingUnit < ActiveRecord::Migration[7.1]
  def change
    create_join_table :queries, :heating do |t|
      # t.index [:query_id, :heating_unit_id]
      # t.index [:heating_unit_id, :query_id]
    end

    rename_table :heating_queries, :planned_heatings
  end
end
