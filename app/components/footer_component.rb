# frozen_string_literal: true

class FooterComponent < ViewComponent::Base
  attr_reader :site, :style

  def initialize(site:, style: :multi_page)
    @site = site
    @style = style
  end

  private
  
  def menu_items
    site.menu_items
  end

  def non_menu_pages
    site.pages.non_menu.blank? ? [] : site.pages.non_menu
  end

  def imprint_items
    site.pages.imprint.blank? ? [] : site.pages.imprint
  end

  def site_logo
    site.logo_with_tag_for_dark&.attached? ? site.logo_with_tag_for_dark : site.name
  end

  def menu_path_for(menu_item)
    case style
    when :multi_page
      menu_item.record.present? ? url_for(menu_item.record) : menu_item.url
    else
      menu_item.record.present? ? "##{menu_item.record.slug}" : "##{menu_item.title.downcase}"
    end
  end
end
