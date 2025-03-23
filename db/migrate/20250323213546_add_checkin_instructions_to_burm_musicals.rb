class AddCheckinInstructionsToBURMMusicals < ActiveRecord::Migration[7.2]
  def change
    add_column :burm_musicals, :checkin_instructions, :text
    add_column :burm_musicals, :additional_joining_info, :text
  end
end
