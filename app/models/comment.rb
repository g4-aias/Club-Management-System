class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
 
  validates :comment,  presence: true, length: { maximum: 200 }
  default_scope -> { order(created_at: :desc) }

  has_ancestry
  
  def is_owner?(user)
    user.id == user_id
  end
end
