class AddHotscoreToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :hotscore, :integer, default: 0
  end
end
