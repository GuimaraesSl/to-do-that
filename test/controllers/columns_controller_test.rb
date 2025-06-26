require "test_helper"

class ColumnsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user
    @board = @user.boards.create!(name: "Board Test")
    @column = @board.columns.create!(name: "To Do", position: 1)
  end

  test "should create column" do
    assert_difference("@board.columns.count") do
      post board_columns_path(@board), params: {
        column: { name: "In Progress", position: 2 }
      }
    end
    assert_redirected_to board_path(@board)
  end

  test "should update column" do
    patch board_column_path(@board, @column), params: {
      column: { name: "Updated Column" }
    }
    assert_redirected_to board_path(@board)
    assert_equal "Updated Column", @column.reload.name
  end

  test "should destroy column" do
    assert_difference("Column.count", -1) do
      delete board_column_path(@board, @column)
    end
    assert_redirected_to board_path(@board)
  end
end
