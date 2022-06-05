# frozen_string_literal: true

class NavbarComponent < ViewComponent::Base
  def initialize(name:, menu_items: [], position: :top, logo: nil)
    @name = name
    @position = position
    @menu_items = menu_items
    @logo = logo
  end

  private

  def logo
    if @logo
      image_tag @logo
    else
      @name
    end
  end

  def nav_wrapper_classes
    base_classes = case @position
    when :left
      "left-0 flex-col justify-start items-end h-screen w-[250px] border-r -translate-x-[250px] md:translate-x-0 bg-white"
    when :right
      "right-0 flex-col justify-start items-start h-screen w-[250px] border-l translate-x-[250px] md:translate-x-0 bg-white"
    else
      "flex-wrap content-start items-stretch md:flex-nowrap left-0
      right-0 items-center justify-between h-fit md:h-20 border-b w-screen flex bg-transparent"
    end

    "flex #{base_classes} transition ease-in duration-500 items-stretch"
  end

  def menu_button_class
    base_classes = case @position
    when :left
      "absolute top-0 left-[249px] rounded-r-lg border border-l-white border-t-0"
    when :right
      "absolute top-0 right-[249px] rounded-l-lg border border-r-white border-t-0"
    else
      "rounded-lg"
    end
    base_classes
  end

  def logo_classes
    case @position
    when :left
      "mb-4 text-right"
    when :right
      "mb-4 text-left"
    else
      "px-4 grow flex flex-col justify-center items-center"
    end
  end

  def menu_wrapper_classes
    case @position
    when :left
      "grow flex flex-col items-end items-stretch text-right"
    when :right
      "grow flex flex-col items-start items-stretch text-left"
    else
      "items-center md:justify-end hidden flex flex-col md:flex md:flex-row md:grow w-full items-stretch text-center"
    end
  end

  def menu_classes
    case @position
    when :left, :right
      "p-2 hover:bg-gray-100"
    else
      "px-4 py-4 md:py-0 flex flex-col items-center justify-center"
    end
  end

end
