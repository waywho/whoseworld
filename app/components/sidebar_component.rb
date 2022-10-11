# frozen_string_literal: true

class SidebarComponent < ViewComponent::Base
  def initialize(logo:, subtitle: nil, menu_items: [], position: :left)
    @logo = logo
    @menu_items = menu_items
    @position = position
    @subtitle = subtitle
  end

  private

  def additional_options
   {
      "data-action"=>"click->scroll#smoothScroll"
    }
  end

  def menu_classes
    "flex items-center p-2 text-base font-normal text-gray-900 rounded-lg dark:text-white hover:bg-gray-100 dark:hover:bg-gray-700"
  end

  def navbar_classes
    case @position
    when :left
      "pl-3 pb-3"
    when :right
      "flex-row-reverse pr-3 pb-3"
    end
  end

  def placement
    case @position
    when :left
      "left-0 pl-4 -translate-x-64 md:-translate-x-0"
    when :right
      "right-0 pr-4 translate-x-64 md:translate-x-0"
    end
  end

  def active_menu_classes
    "text-white bg-blue-700 md:bg-transparent md:text-blue-700 dark:text-white"
  end

  def non_active_menu_classes
    " text-gray-700 dark:text-gray-400"
  end
end
