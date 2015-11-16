class MemberRequest < ActiveRecord::Base
  #belongs_to :user
  #belongs_to :club
  
  belongs_to :club_request, class_name: 'Club' , foreign_key: 'club_id'    
  belongs_to :requesting_user, class_name: 'User' , foreign_key: 'user_id'
  
  def self.req!(club, user)
    #checks if the user is already requesting
    member_request = MemberRequest.where(club_id: club.id, user_id: user.id).first
    return false if member_request
    MemberRequest.create(club_id: club.id, user_id: user.id)
  end
  
  def self.request_exists? (club, user)
    MemberRequest.where(club_id: club.id, user_id: user.id).first
  end
  
  #def self.unreq!(club, user)
    #member_request = MemberRequest.where(club_id: club.id, user_id: user.id).first
    #return false unless member_request
    #member_request.destroy
  #end
  
end
