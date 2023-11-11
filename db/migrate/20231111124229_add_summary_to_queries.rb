class AddSummaryToQueries < ActiveRecord::Migration[7.1]
  def change
    add_column :queries, :summary, :text
  end
end
