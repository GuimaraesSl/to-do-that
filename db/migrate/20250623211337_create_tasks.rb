class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.integer :difficulty
      t.integer :priority
      t.datetime :due_date
      t.datetime :concluded_at
      t.integer :position
      t.references :column, null: false, foreign_key: true

      t.timestamps
    end
  end
end
