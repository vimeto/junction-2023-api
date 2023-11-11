class RenameSteetToStreetInAddresses < ActiveRecord::Migration[7.1]
  def change
    rename_column :addresses, :steet, :street
  end
end
