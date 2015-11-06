class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.references :user, index: true, foreign_key: true
      t.references :club, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
