class AddAttachmentBackgroundToClubs < ActiveRecord::Migration
  def self.up
    change_table :clubs do |t|
      t.attachment :background
    end
  end

  def self.down
    remove_attachment :clubs, :background
  end
end
