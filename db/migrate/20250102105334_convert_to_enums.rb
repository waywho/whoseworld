class ConvertToEnums < ActiveRecord::Migration[7.2]
  def up
    add_column :sites, :nav_position, :integer, default: 0, null: false
    add_column :sites, :layout_style, :integer, default: 0, null: false

    Site.find_each do |site|
      nav_position = site.orientation.present? ? (Site.orientations.index(site.orientation.to_sym) || 0) : 0
      layout_style = site.template_style.present? ? (Site.site_styles.index(site.template_style.to_sym) || 0) : 0

      site.update_columns(nav_position:, layout_style:)
    end

    remove_column :sites, :orientation
    remove_column :sites, :template_style

    rename_column :pages, :template, :old_template
    add_column :pages, :template, :integer, default: 0, null: false

    Page.find_each do |page|
      template = page.old_template.present? ? (Page.templates[page.old_template] || 0) : 0
      page.update_column(:template, template)
    end

    remove_column :pages, :old_template

    rename_column :medias, :media_type, :old_media_type
    add_column :medias, :media_type, :integer

    Media.find_each do |media|
      media_type = media.old_media_type.present? ? Media.types.index(media.old_media_type.to_sym) : 0
      media.update_column(:media_type, media_type)
    end

    remove_column :medias, :old_media_type
  end

  def down
    add_column :sites, :orientation, :string
    add_column :sites, :template_style, :string

    Site.find_each do |site|
      site.update_columns(orientation: Site.nav_positions[site.nav_position] || "top",
                          template_style: Site.layout_styles[site.layout_style]) || "one_page"
    end

    remove_column :sites, :nav_position
    remove_column :sites, :layout_style

    add_column :old_template, :string

    Page.find_each do |page|
      page.update_column(:old_template, Page.templates.invert[page.template])
    end

    remove_column :pages, :template
    rename_column :pages, :old_template, :template

    add_column :medias, :old_media_type, :string

    Media.find_each do |media|
      media.update_column(:old_media_type, Media.media_types.invert[media.media_type])
    end

    remove_column :medias, :media_type
    rename_column :medias, :old_media_type, :media_type
  end
end
