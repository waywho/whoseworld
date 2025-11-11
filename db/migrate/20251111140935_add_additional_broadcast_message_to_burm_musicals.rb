class AddAdditionalBroadcastMessageToBURMMusicals < ActiveRecord::Migration[7.2]
  def change
    add_column :burm_musicals, :additional_broadcast_info, :text
  end
end
