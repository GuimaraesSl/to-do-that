require "test_helper"

class BoardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user
    @board = @user.boards.create!(name: "Test Board", description: "Some description")
  end

  test "should get index" do
    get boards_path
    assert_response :success
    assert_select "h2", text: /Board/i
  end

  test "should show board" do
    get board_path(@board)
    assert_response :success
  end

  test "should create board" do
    assert_difference("Board.count") do
      post boards_path, params: { board: { name: "New Board", description: "Descrição" } }
    end
    assert_redirected_to boards_path
  end

  test "should update board" do
    patch board_path(@board), params: { board: { name: "Updated Board" } }
    assert_redirected_to board_path(@board)
    assert_equal "Updated Board", @board.reload.name
  end

  test "should destroy board" do
    assert_difference("Board.count", -1) do
      delete board_path(@board)
    end
    assert_redirected_to boards_path
  end
end
