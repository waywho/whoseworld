class Image < ApplicationRecord
  belongs_to :record, polymorphic: true

  after_commit :update_cid

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
end
