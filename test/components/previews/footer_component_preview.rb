# frozen_string_literal: true

class FooterComponentPreview < ViewComponent::Preview
  def default
    site = Site.last
    site.pages.upsert_all([
      { title: "About", menu: true },
      { title: "Join", menu: true },
      { title: "Contact", menu: false },
      { title: "Imprint", menu: false },
      { title: "Terms", menu: false },
      { title: "Privacy", menu: false }],
      unique_by: [:site_id, :title])

    render(FooterComponent.new(site:))
  end
end
