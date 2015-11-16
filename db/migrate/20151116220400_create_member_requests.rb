class CreateMemberRequests < ActiveRecord::Migration
  def change
    create_table :member_requests do |t|
      t.references :user, index: true, foreign_key: true
      t.references :club, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
