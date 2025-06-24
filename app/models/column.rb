class Column < ApplicationRecord
  belongs_to :board
  has_many :tasks, -> { order(position: :asc) }, dependent: :destroy

  validates :name, presence: true
  validates :position, presence: true, numericality: { only_integer: true }

  before_validation :set_position, on: :create
  before_create :set_done_column_flag

  private

  def set_position
    return if position.present?
    max_position = board.columns.maximum(:position)
    self.position = (max_position || -1) + 1
  end

  def set_done_column_flag
    board.columns.update_all(is_done_column: false)
    self.is_done_column = true
  end
end
