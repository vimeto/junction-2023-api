class CreateCompanyContacts < ActiveRecord::Migration[7.1]
  def change
    create_table :company_contacts do |t|
      t.string :email
      t.string :phone
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
