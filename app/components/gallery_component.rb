# frozen_string_literal: true

class GalleryComponent < ViewComponent::Base
  include IconsHelper

  def initialize(gallery:, admin:false)
    @gallery = gallery
    @admin = admin
  end
end
