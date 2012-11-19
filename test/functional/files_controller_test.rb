require 'test_helper'

class FilesControllerTest < ActionController::TestCase
  test "should get unzip" do
    get :unzip
    assert_response :success
  end

  test "should get savefile" do
    get :savefile
    assert_response :success
  end

end
