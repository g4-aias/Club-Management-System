class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :club
  
  default_scope -> { order(created_at: :desc) }
  validates :context,  presence: true, length: { maximum: 1000 }
  validates :title,  presence: true, length: { maximum: 60 }
  validates :user_id, presence: true
  validates :club_id, presence: true
  
  
end
