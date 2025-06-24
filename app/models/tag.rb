class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy

  has_many :boards, through: :taggings, source: :taggable, source_type: "Board"
  has_many :tasks, through: :taggings, source: :taggable, source_type: "Task"
end
