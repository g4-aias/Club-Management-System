class CreateClubs < ActiveRecord::Migration
  def change
    create_table :clubs do |t|
      t.string :name
      t.string :description
      t.string :genre
      t.references :user, index: true, foreign_key: true
      t.string :path

      t.timestamps null: false
    end
  end
end
