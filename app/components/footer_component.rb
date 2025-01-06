# frozen_string_literal: true

class FooterComponent < ViewComponent::Base
  attr_reader :site

  def initialize(site:)
    @site = site
  end

  def menu_items
    site.pages.menu.blank? ? [] : site.pages.menu
  end

  def non_menu_items
    site.pages.non_menu.blank? ? [] : site.pages.non_menu
  end

  def site_logo
    site.logo&.attached? ? site.logo : site.name
  end
end
