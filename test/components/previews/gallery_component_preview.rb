# frozen_string_literal: true

class GalleryComponentPreview < ViewComponent::Preview
  def default
    render(GalleryComponent.new(gallery: Gallery.new(id: 123451234)))
  end
end
