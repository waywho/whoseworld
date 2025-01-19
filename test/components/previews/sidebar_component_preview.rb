# frozen_string_literal: true

class SidebarComponentPreview < ViewComponent::Preview
  # @param nav_position select [left, right]
  # @param layout_style select [one_page, multi_page]
  def default(nav_position: "left", layout_style: "multi_page")
    site = set_site(nav_position, layout_style)
    render(SidebarComponent.new(logo: site.name, menu_items: menu_items))
  end

  private

  def logo
    if @logo.attached?
      image_tag @logo
    else
      content_tag :span, @site.name, class: "self-center text-xl font-semibold whitespace-nowrap dark:text-white"
    end
  end

  def set_site(nav_position, layout_style)
    Site.new(
      name: "Amazing Site",
      domain: "amazing-site.com",
      slug: "amazing_site",
      nav_position:,
      subtitle: "Great site",
      layout_style: layout_style
    )
  end

  def menu_items
    ['Here', 'About', 'Services', 'Pricing', 'Contact'].each_with_object([]) do |menu, arr|
        arr << [MenuItem.new(title: menu, url: "/")]
    end
  end
end
