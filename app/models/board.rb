class Board < ApplicationRecord
  belongs_to :user
  has_many :columns, dependent: :destroy
  has_many :tasks, through: :columns

  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggings

  after_create :create_default_columns

  private

  def create_default_columns
    columns.create!([
      { name: "To Do", position: 1, is_done_column: false },
      { name: "In Progress", position: 2, is_done_column: false },
      { name: "Done", position: 3, is_done_column: true }
    ])
  end
end
