class BoardsController < ApplicationController
  before_action :set_board, only: [ :show, :update, :destroy ]

  def index
    @boards = Board.all.includes(:tags).all
  end

  def show
    @board = Board.find(params[:id])
  end

  def create
    @board = Board.new(board_params)
    if @board.save
      redirect_to boards_path, notice: "Board criado com sucesso."
    else
      @boards = Board.includes(:tags).all
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
    @board = Board.find(params[:id])
  end

  def board_params
    params.require(:board).permit(:name, :description, :banner)
  end
end
