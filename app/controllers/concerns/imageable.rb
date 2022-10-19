module Imageable
  extend ActiveSupport::Concern

  private
  def purge_image(image_id)
    @image = ActiveStorage::Attachment.find(image_id)
    @image.purge
  end
end
