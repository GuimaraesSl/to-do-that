class Task < ApplicationRecord
  belongs_to :column
  has_one :board, through: :column

  acts_as_list scope: :column, column: :position

  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggings

  validates :title, presence: true
  validates :difficulty,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 1
            }
  validates :position, presence: true, numericality: { only_integer: true }

  default_scope { order(position: :asc) }

  before_validation :set_position_if_nil, on: :create

  DIFFICULTY_LABELS = {
    1 => "S",
    2 => "M",
    3 => "L"
  }

  def difficulty_label
    DIFFICULTY_LABELS[difficulty] || "Desconhecido"
  end

  def due_date_formatted
    due_date&.strftime("%d/%m/%Y %H:%M")
  end

  private

  def set_position_if_nil
    return if position.present?

    max_position = column.tasks.maximum(:position) || -1
    self.position = max_position + 1
  end
end
