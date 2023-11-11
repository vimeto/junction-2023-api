class CreateQuotaDiscussions < ActiveRecord::Migration[7.1]
  def change
    create_table :quota_discussions do |t|

      t.timestamps
    end
  end
end
