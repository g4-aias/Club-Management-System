class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :club
  
  validates :context,  presence: true, length: { maximum: 1000 }
  validates :title,  presence: true, length: { maximum: 100 }
  
end
