class TasksController < ApplicationController
  before_action :set_column
  before_action :set_task, only: %i[show update destroy move]

  def create
    @task = @column.tasks.build(task_params)
    @task.concluded_at = Time.current if @column == @column.board.columns.order(:id).last

    if @task.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to board_path(@column.board) }
      end
    else
      respond_to do |format|
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace("new_task_errors", partial: "tasks/errors", locals: { task: @task })
        }
        format.html { redirect_to board_path(@column.board), alert: "Erro ao criar tarefa" }
      end
    end
  end

  def show
    respond_to do |format|
      format.turbo_stream
    end
  end

  def update
    if @task.update(task_params)
      respond_to do |format|
        format.html { redirect_to board_path(@column.board) }
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.html { redirect_to board_path(@column.board) }
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace("edit_task_errors", partial: "tasks/errors", locals: { task: @task })
        }
      end
    end
  end

  def destroy
    @task.destroy
    redirect_to board_path(@task.column.board)
  end

  def move
    @old_column = @task.column
    @new_column = current_user.boards.find(@old_column.board_id).columns.find(params[:target_column_id])
    new_pos = params[:new_position].to_i + 1

    Task.transaction do
      if @new_column == @old_column
        @task.insert_at(new_pos)
      else
        @task.column = @new_column
        @task.concluded_at = @new_column == @new_column.board.columns.order(:id).last ? Time.current : nil
        @task.save!
        @task.insert_at(new_pos)
      end
    end

    respond_to do |format|
      format.turbo_stream
      format.json { head :ok }
    end
  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  private

  def set_column
    @column = current_user.boards.joins(:columns).merge(Column.where(id: params[:column_id])).first.columns.find(params[:column_id])
  end

  def set_task
    @task = @column.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :difficulty, :due_date, :position, tag_ids: [])
  end
end
