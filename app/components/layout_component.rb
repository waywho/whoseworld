# frozen_string_literal: true

class LayoutComponent < ViewComponent::Base
  renders_one :navigation, -> (position: @position, menu: nil, logo: @logo) do
    items = menu || menu_items
    case position
    when :top
      NavbarComponent.new(logo: logo, menu_items: items)
    when :left, :right
      SidebarComponent.new(logo: logo, menu_items: items, position: position)
    end
  end

  def initialize(site:)
    @site = site
    @position = @site.orientation.to_sym || :top
    @logo = @site.logo
    @style = @site.template_style.to_sym
  end

  def menu_items
    items = (@site.pages.menu_pages.blank? ? [] : @site.pages.menu_pages)
    menu_items = case @style
    when :multi_page
      items.map { |m| [m.title, url_for(m)] }
    when :one_page
      items.map { |m| [m.title, "##{m.slug}"] }
    end
  end

  private

  def scroll_controller
    "scroll" if @style == :one_page
  end

  def style_class
    case @position
    when :top
      "mt-24 mx-auto"
    when :left
      "px-6 py-12 md:pr-16 md:pl-72"
    when :right
      "px-6 py-12 md:pl-16 md:pr-72"
    end
  end

  def navbar_component
    case @position
    when :top
      render NavbarComponent.new(logo: @logo, menu_items: menu_items)
    when :left, :right
      render SidebarComponent.new(logo: @logo, menu_items: menu_items, position: @position)
    end
  end

end
