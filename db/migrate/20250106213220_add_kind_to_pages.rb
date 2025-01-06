class AddKindToPages < ActiveRecord::Migration[7.2]
  def up
    add_column :pages, :kind, :integer
    add_index :pages, [:kind, :site_id]

    Page.all.each do |page|
      if page.menu?
        page.update(kind: :menu)
      elsif page.title.include?("landing")
        page.update(kind: :landing)
      elsif page.feature?
        page.update(kind: :feature)
      elsif ["imprint", "privacy policy", "terms of service"].include?(page.title.downcase)
        page.update(kind: :imprint)
      else
        page.update(kind: :non_menu)
      end
    end

    remove_column :pages, :menu
    remove_column :pages, :feature
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
