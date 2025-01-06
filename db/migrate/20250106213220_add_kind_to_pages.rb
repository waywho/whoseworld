class AddKindToPages < ActiveRecord::Migration[7.2]
  disable_ddl_transaction!
  def up
    ActiveRecord::Base.transaction do
      add_column :pages, :kind, :integer, default: 0, null: false
      add_index :pages, [:kind, :site_id]

      Page.reset_column_information
      label_keys = Page::KIND_LABELS.keys
      Page.all.each do |page|
        if page.menu?
          page.update!(kind: label_keys.index(:menu))
        elsif page.slug.include?("landing")
          page.update!(kind: label_keys.index(:landing))
        elsif page.feature?
          page.update!(kind: label_keys.index(:feature))
        elsif ["imprint", "privacy policy", "terms of service"].include?(page.title.downcase)
          page.update!(kind: label_keys.index(:imprint))
        else
          page.update!(kind: label_keys.index(:non_menu))
        end
      end

      remove_column :pages, :menu
      remove_column :pages, :feature
    end
  end

  def down
    add_column :pages, :menu, :boolean, default: false
    add_column :pages, :feature, :boolean, default: false

    Page.all.each do |page|
      case page.kind
      when "menu"
        page.update(menu: true)
      when "landing"
        page.update(title: "#{page.title} landing")
      when "feature"
        page.update(feature: true)
      when "imprint"
        page.update(title: "imprint")
      else
        page.update(menu: false)
      end
    end

    remove_column :pages, :kind
  end
end
