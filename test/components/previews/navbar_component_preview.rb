# frozen_string_literal: true

class NavbarComponentPreview < ViewComponent::Preview
  # @display padding 0px
  # @param orientation select [top, left, right]
  # @param style select [one_page, multi_page]
  def default(orientation: "top", style: "multi_page")
    # site = Site.last
    site = set_site(orientation, style)
    render(NavbarComponent.new(logo: site.name, menu_items: menu_items))
  end

  private

  def set_site(orientation, style)
    site = Site.new(
      name: "Amazing Site",
      domain: "amazing-site.com",
      slug: "amazing_site",
      orientation: orientation,
      subtitle: "Great site",
      template_style: style
    )
  end

  def menu_items
    ['Here', 'About', 'Services', 'Pricing', 'Contact'].each_with_object([]) do |menu, arr|
        arr << [menu, ""]
    end
  end
end
