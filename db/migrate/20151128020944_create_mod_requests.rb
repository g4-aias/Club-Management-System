class CreateModRequests < ActiveRecord::Migration
  def change
    create_table :mod_requests do |t|
      t.references :user, index: true, foreign_key: true
      t.references :club, index: true, foreign_key: true
      t.integer :inviting_user_id

      t.timestamps null: false
    end
  end
end
