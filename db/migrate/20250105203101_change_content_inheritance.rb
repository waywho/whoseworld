class ChangeContentInheritance < ActiveRecord::Migration[7.2]
  def up
    ActiveRecord::Base.transaction do
      add_column :contents, :contentable_type, :string
      add_column :contents, :contentable_id, :bigint
      add_index :contents, :contentable_type
      add_index :contents, %i[contentable_type contentable_id]

      Content.reset_column_information

      Content.all.each do |content|
        content.update(contentable_type: "Page", contentable_id: content.page_id)
      end

      remove_column :contents, :page_id
    end
  end

  def down
    ActiveRecord::Base.transaction do
      add_column :contents, :page_id, :bigint

      Content.all.each do |content|
        content.update(page_id: content.contentable_id)
      end

      remove_column :contents, :contentable_type
      remove_column :contents, :contentable_id
    end
  end
end
