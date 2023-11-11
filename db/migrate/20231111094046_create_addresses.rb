class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.string :steet
      t.string :city
      t.string :state
      t.string :zipcode

      t.timestamps
    end
  end
end
