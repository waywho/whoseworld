class ImageCidJob < ApplicationJob
  queue_as :default

  def perform(image)
    return unless image&.image&.blob&.key

    object = client.get_object(
      bucket: Rails.application.credentials.filebase[:bucket],
      key: image.image.blob.key
    )

    update_columns(cid: object.metadata["cid"])
  end

  def client
    @client = Aws::S3::Client.new(
      **Rails.application.credentials.filebase.except(:bucket)
    )
  end
end
