class CreateQuotaMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :quota_messages do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.references :company_contact, null: false, foreign_key: true

      t.timestamps
    end
  end
end
