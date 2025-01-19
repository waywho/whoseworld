# frozen_string_literal: true

class NavbarComponent < ViewComponent::Base
  attr_reader :style

  def initialize(logo:, subtitle: nil, menu_items: [], style: :multi_page)
    @logo = logo
    @menu_items = menu_items
    @subtitle = subtitle
    @style = style
  end

  private

  def active_menu_classes
    " text-white bg-blue-700 md:bg-transparent md:text-blue-700 dark:text-white"
  end

  def non_active_menu_classes
    " text-gray-700 dark:text-gray-400"
  end

  def menu_classes
    "block py-2 pr-4 pl-3 rounded hover:bg-gray-100 md:hover:bg-transparent md:border-0 md:hover:text-blue-700 md:p-0 md:dark:hover:text-white dark:hover:bg-gray-700 dark:hover:text-white md:dark:hover:bg-transparent"
  end

  def menu_path_for(menu_item)
    case style
    when :multi_page
      menu_item.record.present? ? url_for(menu_item.record) : menu_item.url
    else
      menu_item.record.present? ? "##{menu_item.record.slug}" : "#{menu_item.title.downcase}"
    end
  end
end
