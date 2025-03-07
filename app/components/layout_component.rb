# frozen_string_literal: true

class LayoutComponent < ViewComponent::Base
  renders_one :navigation, ->(&block) do
    case nav_position
    when :top
      NavbarComponent.new(logo:, subtitle: @subtitle, menu_items:, style:, &block)
    when :left, :right
      SidebarComponent.new(logo:, subtitle: @subtitle, menu_items:, position: nav_position, style:, &block)
    end
  end

  renders_one :footer, ->(&block) do
    FooterComponent.new(site: @site, style:, &block)
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
    else
      menus
    end
  end

  private

  def logo
    return "Admin" if @admin

    if @site&.logo_with_tag&.attached?
      @site&.logo_with_tag
    elsif @site&.logo&.attached?
      @site&.logo
    else
      @site&.name
    end
  end

  def menus
    @site.menu_items
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
      "container mt-24 my-32 mx-auto"
    when :left
      "px-6 py-12 md:pr-24 md:pl-80"
    when :right
      "px-6 py-12 md:pl-24 md:pr-80"
    end
  end
end
