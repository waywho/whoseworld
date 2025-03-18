# frozen_string_literal: true

class GalleryComponent < ViewComponent::Base
  include IconsHelper
  include ImageHelper

  def initialize(gallery:, admin:false)
    @gallery = gallery
    @admin = admin
  end
end
