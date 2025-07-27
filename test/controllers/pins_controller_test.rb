require "test_helper"

class PinsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get pins_new_url
    assert_response :success
  end

  test "should get create" do
    get pins_create_url
    assert_response :success
  end
end
