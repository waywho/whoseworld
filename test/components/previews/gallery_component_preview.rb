# frozen_string_literal: true

class GalleryComponentPreview < ViewComponent::Preview
  def default
    render(GalleryComponent.new(gallery: Gallery.last))
  end
end
