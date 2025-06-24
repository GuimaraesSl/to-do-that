require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get root_path
    assert_response :success
    assert_select "h1", text: "Bem-vindo" # exemplo: testa se tem um h1 com "Bem-vindo"
  end
end
