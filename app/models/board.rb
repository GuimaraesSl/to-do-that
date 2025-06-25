class Board < ApplicationRecord
  belongs_to :user
  has_many :columns, dependent: :destroy
  has_many :tasks, through: :columns

  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggings

  validates :name, presence: true
  validates :banner, length: { maximum: 3.megabyte }, allow_nil: true

  after_create :create_default_columns

  def create_default_columns
    columns.create!([
      { name: "To Do", position: 1, is_done_column: false },
      { name: "In Progress", position: 2, is_done_column: false },
      { name: "Done", position: 3, is_done_column: true }
    ])
  end

  def promote_last_column_to_done!
    columns.update_all(is_done_column: false)
    columns.order(:position).last&.update(is_done_column: true)
  end
end
