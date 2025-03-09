# frozen_string_literal: true

require "test_helper"

class BURM::MusicalTest < ActiveSupport::TestCase
  setup do
    @musical = create(:burm_musical)
    @person = create(:burm_person, email: "walzerfan@yahoo.com")
  end

  test "should initialize client" do
    mock = Minitest::Mock.new
    mock.expect :send_batch, true, [Hash, Array]

    BatchMailClient.stub :new, mock do
      MusicalMailerService.new(:signup_open, musical: @musical, test: true).send_mail
      assert_mock mock
    end
  end
end
