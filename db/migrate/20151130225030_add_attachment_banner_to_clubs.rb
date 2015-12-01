class AddAttachmentBannerToClubs < ActiveRecord::Migration
  def self.up
    change_table :clubs do |t|
      t.attachment :banner
    end
  end

  def self.down
    remove_attachment :clubs, :banner
  end
end
