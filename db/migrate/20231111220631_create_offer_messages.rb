class CreateOfferMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :offer_messages do |t|
      t.references :offer_discussion, null: false, foreign_key: true

      t.string :content

      t.timestamps
    end
  end
end
