class UserMetrics
  def initialize(user)
    @user = user
  end

  def completed_tasks_count
    Task
      .joins(column: :board)
      .where(boards: { user_id: @user.id })
      .where.not(concluded_at: nil)
      .count
  end

  def completed_tasks_per_board
    Board
      .includes(columns: :tasks)
      .where(user_id: @user.id)
      .map do |board|
        tasks = board.columns.flat_map(&:tasks)
        total_tasks = tasks.size
        completed_tasks = tasks.count { |task| task.concluded_at.present? }

        next if total_tasks.zero?

        {
          name: board.name,
          count: completed_tasks,
          total: total_tasks
        }
      end
      .compact
      .sort_by { |b| -b[:count] }
      .first(5)
  end

  def task_distribution_per_board
    boards = Board
      .includes(columns: :tasks)
      .where(user_id: @user.id)

    Rails.logger.debug "Boards encontrados: #{boards.count}, User ID: #{@user.id}"

    result = boards.map do |board|
      tasks = board.columns.flat_map(&:tasks)
      total_tasks = tasks.count
      Rails.logger.debug "Board: #{board.name}, Total Tasks: #{total_tasks}"

      { name: board.name, count: total_tasks }
    end

    result.select { |board| board[:count].positive? }.presence || []
  end

  def tasks_due_today
    Task
      .includes(:tags, column: :board)
      .where(boards: { user_id: @user.id })
      .where(due_date: Time.zone.today.all_day)
      .where(concluded_at: nil)
      .order(:due_date)
  end
end
