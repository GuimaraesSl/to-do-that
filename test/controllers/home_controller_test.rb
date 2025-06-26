require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user
  end

  test "should get index with metrics" do
    get root_path
    assert_response :success
    assert_select "h1", text: "Como Estou Indo"

    assert assigns(:metrics)
    assert assigns(:tasks_due_today)
    assert assigns(:task_distribution_data)
  end
end
