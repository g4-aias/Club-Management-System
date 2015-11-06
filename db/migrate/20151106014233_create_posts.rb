class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :context
      t.string :title
      t.string :url
      t.references :user, index: true, foreign_key: true
      t.references :club, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
