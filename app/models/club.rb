class Club < ActiveRecord::Base
  belongs_to :user

  has_many :moderators,through: :moderations
  has_many :moderations
  has_many :posts
  has_many :members, through: :memberships
  has_many :memberships
  
  
  has_many :requesting_users, through: :member_requests
  has_many :member_requests
  
  after_create :make_owner_mod
  after_create :make_owner_member
  #after_create :downcase_path
  before_save :set_club_path
  
 
  
  validates :name,  presence: true, length: { maximum: 70 },
                        uniqueness: { case_sensitive: false }
  validates :description,  presence: true, length: { maximum: 1000 }
  validates :genre,  presence: true, length: { maximum: 50 }
  #validates :user_id, presence: true
  
  
  has_attached_file :background, styles: { :medium => "300x300>", large: "1024x768>" }
  validates_attachment_content_type :background, content_type: /\Aimage\/.*\Z/

  
  def self.by_path(path)
    Club.where('path=?', path).first
  end
  
  def is_member?(user)
    members.include?(user)
  end
  
  def is_owner?(user)
    user.id == user_id
  end
  
  def is_moderator?(user)
    moderators.include?(user)
  end

#user ILIKE for PostgrSQL

  def self.search(search)
    where 'name LIKE :search OR description LIKE :search OR genre LIKE :search', :search => "%#{search}%"
  end
  
  #def order(order)
   # @clubs = Club.find(:all)
  #end
    
  
 
  private
  
  def downcase_path
    self.path = path.downcase
  end
  
  def set_club_path
    self.path = name  
    self.path = path.downcase
  end
  
  def make_owner_mod
    Moderation.create!(user_id: user_id, club_id: id)
  end
  
  def make_owner_member
    Membership.create!(user_id: user_id, club_id: id)
  end
  
  
  
end
