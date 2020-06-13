require 'test_helper'

class WebsitesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get websites_index_url
    assert_response :success
  end

  test "should get show" do
    get websites_show_url
    assert_response :success
  end

end
