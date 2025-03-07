require "test_helper"

class ImageCidJobTest < ActiveJob::TestCase
  setup do
    @image = create(:image, imageable: create(:burm_musical), image: fixture_file_upload("image.jpg"))
  end

  test "populate cid" do
    mock = Minitest::Mock.new
    mock.expect :metadata, { "cid" => "1234" }

    client_stub = Aws::S3::Client.new(stub_responses: {
      get_object: mock})

    Aws::S3::Client.stub(:new, client_stub) do
      ImageCidJob.perform_now(@image)
      assert @image.cid == "1234"
    end
  end
end
