class TasksController < ApplicationController
  before_action :set_column
  before_action :set_task, only: [ :show, :update, :destroy, :move ]

  def create
    @task = @column.tasks.build(task_params)

    last_column = @column.board.columns.order(:id).last
    @task.concluded_at = Time.current if @column == last_column

    if @task.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to board_path(@column.board) }
      end
    else
      respond_to do |format|
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(
            "new_task_errors",
            partial: "tasks/errors",
            locals: { task: @task }
          )
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
    @new_column = Column.find(params[:target_column_id])
    new_pos = params[:new_position].to_i + 1

    Task.transaction do
      if @new_column == @old_column
        @task.insert_at(new_pos)
      else
        @task.column = @new_column

        last_column = @new_column.board.columns.order(:id).last
        @task.concluded_at = (@new_column == last_column) ? Time.current : nil

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
    @column = Column.find(params[:column_id])
    puts "Column ID: #{@column.id}"
  end

  def set_task
    @task = Task.find(params[:id])
    puts "Task ID: #{@task.id}"
  end

  def task_params
    params.require(:task).permit(:title, :description, :difficulty, :due_date, :position, tag_ids: [])
  end
end
