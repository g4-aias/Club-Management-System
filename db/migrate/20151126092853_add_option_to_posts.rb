class AddOptionToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :option, :string
  end
end
