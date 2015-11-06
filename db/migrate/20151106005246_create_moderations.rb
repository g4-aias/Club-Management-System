class CreateModerations < ActiveRecord::Migration
  def change
    create_table :moderations do |t|
      t.references :club, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
