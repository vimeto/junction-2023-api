class AddHouseSqmToQuery < ActiveRecord::Migration[7.1]
  def change
    add_column :queries, :houseSqm, :decimal, precision: 10
  end
end
