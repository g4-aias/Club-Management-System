class Club < ActiveRecord::Base
  belongs_to :user

  
  has_many :moderators,through: :moderations
  has_many :moderations
  has_many :posts
  has_many :members, through: :memberships
  has_many :memberships
  

  
  after_create :make_owner_mod
  after_create :make_owner_member
  #after_create :downcase_path
  before_save :set_club_path
  
  validates :name,  presence: true, length: { maximum: 70 },
                        uniqueness: { case_sensitive: false }
  validates :description,  presence: true, length: { maximum: 150 }

  
  def self.by_path(path)
    Club.where('path=?', path).first
  end
  
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
