module IconsHelper
  def icon(name, css = nil)
    icon_name, size = name.split(" ")
    sizing = {
      "1" => "w-4 h-4",
      "2x" => "w-6 h-6",
      "3x" => "w-8 h-8"
    }
    image_tag "icons/#{icon_name}", class: "#{sizing[size]} #{css}"
  end
end
