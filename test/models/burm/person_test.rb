# frozen_string_literal: true

require "test_helper"

class BURM::PersonTest < ActiveSupport::TestCase
  setup do
    @person = create(:burm_person)
  end

  test "#full_name should give full name" do
    assert_equal "#{@person.first_name} #{@person.last_name}", @person.full_name
  end
end
