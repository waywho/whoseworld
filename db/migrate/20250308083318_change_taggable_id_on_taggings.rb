class ChangeTaggableIdOnTaggings < ActiveRecord::Migration[7.2]
  def change
    add_column :taggings, :taggable_id_new, :uuid
    remove_column :taggings, :taggable_id
    rename_column :taggings, :taggable_id_new, :taggable_id
  end
end
