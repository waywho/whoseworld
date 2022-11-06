module Imageable
  extend ActiveSupport::Concern

  private
  def update_image(resource, params)
    resource.attachment_reflections.flat_map do |attachment_key|
      next unless params[:attachment_key.to_sym]

      resource.send(attachment_key.to_sym).attach(params[attachment_key.to_sym])
    end.compact.all?(&:present?)
  end

  def purge_image(image_id)
    @image = ActiveStorage::Attachment.find(image_id)
    @image.purge
  end
end
