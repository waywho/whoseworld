# frozen_string_literal: true

class LayoutComponent < ViewComponent::Base
  renders_one :navigation, -> (position: nav_position, menu: menu_items, subtitle: @subtitle, site_logo: logo) do
    items = menu
    case position
    when :top
      NavbarComponent.new(logo: site_logo, subtitle: subtitle, menu_items: items)
    when :left, :right
      SidebarComponent.new(logo: site_logo, subtitle: subtitle, menu_items: items, position:)
    end
  end

  def initialize(site:, admin: false)
    @admin = admin
    @site = site
    @subtitle = @site&.subtitle
  end

  def menu_items
    case style
    when :multi_page_admin
      menus.map { |m| [m[:title], m[:url]] }
    when :multi_page
      menus.map { |m| [m.title, url_for(m)] }
    when :one_page
      menus.map { |m| [m.title, "##{m.slug}"] }
    end
  end

  private

  def logo
    return "Admin" if @admin

    @site&.logo&.attached? ? @site&.logo : @site&.name
  end

  def menus
    return [
      { title: "Sites", url: admin_sites_path },
      { title: "Pages", url: admin_pages_path(site_id: @site&.id) },
      { title: "Galleries", url: admin_galleries_path(site_id: @site&.id) },
      { title: "Medias", url: admin_medias_path(site_id: @site&.id) }
    ] if admin?

    @site.pages.menu_pages.blank? ? [] : @site.pages.menu_pages
  end

  def style
    return :multi_page_admin if admin?

    @site&.layout_style.to_sym
  end

  def admin?
    @admin
  end

  def nav_position
    return :top if admin?

    @site.nav_position.to_sym || :top
  end

  def scroll_controller
    "scroll" if style == :one_page
  end

  def style_class
    case nav_position
    when :top
      "container mt-24 mx-auto"
    when :left
      "px-6 py-12 md:pr-24 md:pl-80"
    when :right
      "px-6 py-12 md:pl-24 md:pr-80"
    end
  end

  def navbar_component
    case nav_position
    when :top
      render NavbarComponent.new(logo: logo, subtitle: @subtitle, menu_items: menu_items)
    when :left, :right
      render SidebarComponent.new(logo: logo, subtitle: @subtitle, menu_items: menu_items, position: position)
    end
  end

end
