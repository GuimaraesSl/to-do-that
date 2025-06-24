require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    user = FactoryBot.create(:user)
    get new_user_session_path
    sign_in user

    # stub do helper
    Rails.application.routes.default_url_options[:host] = "localhost:3000"
    self.class.include Devise::OmniAuth::UrlHelpers rescue nil

    get root_path
    assert_response :success
  end
end
