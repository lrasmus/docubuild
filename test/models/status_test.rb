require 'test_helper'

class StatusTest < ActiveSupport::TestCase
  test "default scope" do
    assert_equal 4, Status.count
  end

  test "displayable scope" do
    assert_equal 3, Status.displayable.count
  end
end
