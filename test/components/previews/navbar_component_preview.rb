# frozen_string_literal: true

class NavbarComponentPreview < ViewComponent::Preview
  def default
    menu_items = (1..5).collect{ |x| ["menu #{x}", "#"]}
    render(NavbarComponent.new(name: "weihsihu", position: :top, menu_items: menu_items))
  end

  def left
    menu_items = (1..5).collect{ |x| ["menu #{x}", "#"]}
    render(NavbarComponent.new(name: "logical thinking", position: :left, menu_items: menu_items))
  end

  def right
    menu_items = (1..5).collect{ |x| ["menu #{x}", "#"]}
    render(NavbarComponent.new(name: "storychor", position: :right, menu_items: menu_items))
  end
end
