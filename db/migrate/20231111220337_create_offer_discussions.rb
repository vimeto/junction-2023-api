class CreateOfferDiscussions < ActiveRecord::Migration[7.1]
  def change
    create_table :offer_discussions do |t|
      t.references :query, null: false, foreign_key: true
      t.references :company_contact, null: false, foreign_key: true

      t.string :name

      t.timestamps
    end
  end
end
