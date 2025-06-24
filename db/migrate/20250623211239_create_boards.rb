class CreateBoards < ActiveRecord::Migration[8.0]
  def change
    create_table :boards do |t|
      t.string :name
      t.text :description
      t.text :banner
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
