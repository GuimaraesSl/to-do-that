class CreateColumns < ActiveRecord::Migration[8.0]
  def change
    create_table :columns do |t|
      t.string :name
      t.integer :position
      t.boolean :is_done_column
      t.references :board, null: false, foreign_key: true

      t.timestamps
    end
  end
end
