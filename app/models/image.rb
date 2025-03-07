class Image < ApplicationRecord
  belongs_to :imageable, polymorphic: true
  has_one_attached :image

  after_commit :update_cid, on: %i[create update]
  after_destroy_commit :delete_image_from_storage

  private

  def update_cid
    object = client.get_object(
      bucket: Rails.application.credentials.filebase[:bucket],
      key: blob.key
    )

    update_column(cid: object.metadata["cid"])
  end

  def client
    @client = Aws::S3::Client.new(
      **Rails.application.credentials.filebase.except(:bucket)
    )
  end

  def delete_image_from_storage
    image.purge
  end
end
