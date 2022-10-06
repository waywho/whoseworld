# frozen_string_literal: true

class LayoutComponent < ViewComponent::Base
  renders_one :navigation, -> (placement: nil, menu: nil, logo: @logo) do
    items = menu || menu_items
    case placement
    when :top
      NavbarComponent.new(logo: logo, menu_items: items)
    when :left, :right
      SidebarComponent.new(logo: logo, menu_items: items, position: placement)
    end
  end

  def initialize(site:, admin: false)
    @admin = admin
    @site = site
    @logo = @site.logo.attached? ? @site.logo : @site.name
    @style = @site.template_style.to_sym
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

  def menus
    return [
      { title: "Pages", url: admin_sites_path },
      { title: "Pages", url: admin_pages_path },
      { title: "Galleries", url: admin_galleries_path }
    ] if admin?

    @site.pages.menu_pages.blank? ? [] : @site.pages.menu_pages
  end

  def style
    return :multi_page_admin if admin?

    @style
  end

  def admin?
    @admin
  end

  def position
    return :left if admin?

    @site.orientation || :top
  end

  def scroll_controller
    "scroll" if style == :one_page
  end

  def style_class
    case position
    when :top
      "mt-24 mx-auto"
    when :left
      "px-6 py-12 md:pr-16 md:pl-72"
    when :right
      "px-6 py-12 md:pl-16 md:pr-72"
    end
  end

  def navbar_component
    case position
    when :top
      render NavbarComponent.new(logo: @logo, menu_items: menu_items)
    when :left, :right
      render SidebarComponent.new(logo: @logo, menu_items: menu_items, position: position)
    end
  end

end
