# frozen_string_literal: true

class NavbarComponent < ViewComponent::Base
  def initialize(logo:, subtitle: nil, menu_items: [])
    @logo = logo
    @menu_items = menu_items
    @subtitle = subtitle
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

end
