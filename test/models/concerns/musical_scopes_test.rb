# frozen_string_literal: true

require "test_helper"

class MusicalScopesTest < ActiveSupport::TestCase
  class DummyRole < ActiveRecord::Base
    self.table_name = "burm_roles"
  end

  setup do
    @musical = create(:burm_musical)
    @role = create(:burm_role, musical: @musical)

    DummyRole.include MusicalScopes
  end

  test "class should respond to site scopes" do
    assert_respond_to DummyRole, @musical.symbolized_slug
  end
end
