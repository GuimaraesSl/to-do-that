class BoardsController < ApplicationController
  before_action :set_board, only: %i[show update destroy]

  def index
    @boards = current_user.boards.includes(:tags)
  end

  def show
  end

  def create
    @board = current_user.boards.new(board_params)
    if @board.save
      redirect_to boards_path, notice: "Board criado com sucesso."
    else
      @boards = current_user.boards.includes(:tags)
      render :index, status: :unprocessable_entity
    end
  end

  def update
    if @board.update(board_params)
      redirect_to @board, notice: "Board atualizado com sucesso."
    else
      render :edit
    end
  end

  def destroy
    @board.destroy
    redirect_to boards_path, notice: "Board apagado com sucesso."
  end

  private

  def set_board
    @board = current_user.boards.find(params[:id])
  end

  def board_params
    params.require(:board).permit(:name, :description, :banner)
  end
end
