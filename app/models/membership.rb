class Membership < ActiveRecord::Base
  #belongs_to :user
  belongs_to :memClub, class_name: 'Club' , foreign_key: 'club_id'     #memClub=member of club
  belongs_to :member, class_name: 'User' , foreign_key: 'user_id'
  #belongs_to :club
  
  
  def self.subscribe!(club, user)
    membership = Membership.where(club_id: club.id, user_id: user.id).first
    return false if membership
    Membership.create(club_id: club.id, user_id: user.id)
  end
  
  
  def self.unsubscribe!(club, user)
    membership = Membership.where(club_id: club.id, user_id: user.id).first
    return false unless membership
    membership.destroy
  end
  
end
