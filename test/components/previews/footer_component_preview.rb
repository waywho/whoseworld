# frozen_string_literal: true

class FooterComponentPreview < ViewComponent::Preview
  def default
    site = Site.last
    site.pages.upsert_all([
      { title: "About", kind: :menu },
      { title: "Join", kind: :menu },
      { title: "Contact", kind: :non_menu },
      { title: "Imprint", kind: :imprint },
      { title: "Terms", kind: :imprint },
      { title: "Privacy", kind: :imprint }],
      unique_by: [:site_id, :title])

    render(FooterComponent.new(site:))
  end
end
