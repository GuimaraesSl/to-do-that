require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    user = FactoryBot.create(:user)

    get new_user_session_path

    sign_in user
    get root_path
    assert_response :success
  end
end
