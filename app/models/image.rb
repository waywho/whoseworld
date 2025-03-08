class Image < ApplicationRecord
  belongs_to :imageable, polymorphic: true
  has_one_attached :image
  include RankedModel
  ranks :row_order, with_same: %i[imageable_id imageable_type]

  before_validation :set_kind
  after_commit :update_cid, on: %i[create update]
  after_destroy_commit :delete_image_from_storage

  delegate :attached?, to: :image

  private

  def set_kind
    association = imageable.class.reflect_on_all_associations.find do |assoc|
      assoc.class_name == self.class.name
    end

    self.kind = association.options[:name]
  end

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
