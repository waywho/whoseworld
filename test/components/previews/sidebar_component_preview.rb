# frozen_string_literal: true

class SidebarComponentPreview < ViewComponent::Preview
  # @param orientation select [left, right]
  # @param style select [one_page, multi_page]
  def default(orientation: "left", style: "multi_page")
    site = set_site(orientation, style)
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
