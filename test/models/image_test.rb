require "test_helper"

class ImageTest < ActiveSupport::TestCase
  setup do
    @image = build(:image, imageable: create(:burm_musical), image: fixture_file_upload("image.jpg"))
  end

  test "populate cid" do
    @image.save
    assert_enqueued_with(job: ImageCidJob, args: [@image])
  end

  test "populate kind" do
    @image.save
    assert "image", @image.kind
  end
end
