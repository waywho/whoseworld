# frozen_string_literal: true

class NavbarComponentPreview < ViewComponent::Preview
  # @display padding 0px
  # @param nav_position select [top, left, right]
  # @param layout_style select [one_page, multi_page]
  def default(nav_position: "top", layout_style: "multi_page")
    # site = Site.last
    site = set_site(nav_position, layout_style)
    render(NavbarComponent.new(logo: site.name, menu_items: menu_items))
  end

  private

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
    ["Here", "About", "Services", "Pricing", "Contact"].each_with_object([]) do |menu, arr|
        arr << [MenuItem.new(title: menu, url: "/")]
    end
  end
end
