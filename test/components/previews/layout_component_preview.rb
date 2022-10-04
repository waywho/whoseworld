# frozen_string_literal: true

class LayoutComponentPreview < ViewComponent::Preview
  # @display padding 0px
  # @param orientation select [top, left, right]
  # @param style select [one_page, multi_page]
  def default(orientation: :top, style: :multi_page)
    site = set_site(orientation, style)
    items = menu_items
    render_with_template(locals: {
      site: site,
      orientation: orientation,
      menu_items: items
    })
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
