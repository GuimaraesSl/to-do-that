require "ostruct"

class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    metrics = UserMetrics.new(current_user)

    @metrics = OpenStruct.new(
      completed_tasks_per_board: metrics.completed_tasks_per_board || [],
      task_distribution_data: metrics.task_distribution_per_board || []
    )

    @tasks_due_today = metrics.tasks_due_today
    @task_distribution_data = metrics.task_distribution_per_board # Adiciona esta linha

    Rails.logger.debug "Task Distribution Data: #{@task_distribution_data.inspect}"
  end
end
