# frozen_string_literal: true

require "test_helper"

class BURM::PersonTest < ActiveSupport::TestCase
  setup do
    @person = create(:burm_person)
  end

  test "validates email uniquness" do
    person = build(:burm_person, email: @person.email)

    assert_not person.valid?
  end

  test "#full_name should give full name" do
    assert_equal "#{@person.first_name} #{@person.last_name}", @person.full_name
  end

  test "#subscribe! should add newsletter to subscription list" do
    @person.subscribe!

    assert @person.subscription_list.include?("newsletter")
  end

  test "#unsubscribe! should remove newsletter to subscription list" do
    @person.subscription_list.add("newsletter")
    @person.save!

    @person.unsubscribe!

    assert_not @person.subscription_list.include?("newsletter")
    assert @person.subscription_list.include?("unsubscribed")
  end
end
