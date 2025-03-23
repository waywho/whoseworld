class AddDirectionNotesToAddresses < ActiveRecord::Migration[7.2]
  def change
    add_column :addresses, :direction_notes, :text
  end
end
