class Task < ApplicationRecord
  belongs_to :column
  has_one :board, through: :column

  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggings
end
