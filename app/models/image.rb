class Image < ApplicationRecord
  belongs_to :imageable, polymorphic: true
  has_one_attached :image
  include RankedModel
  ranks :row_order, with_same: %i[imageable_id imageable_type]

  after_commit :update_cid, on: %i[create update]
  after_destroy_commit :delete_image_from_storage

  private

  def update_cid
    return unless image&.attached?

    ImageCidJob.perform_later(self)
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
