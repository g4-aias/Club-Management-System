class AddClubAvatarToClubs < ActiveRecord::Migration
  def self.up
    change_table :clubs do |t|
      t.attachment :club_avatar
    end
  end

  def self.down
    drop_attached_file :clubs, :club_avatar
  end
end
