class Membership < ActiveRecord::Base
  #belongs_to :user
  belongs_to :memClub, class_name: 'Club' , foreign_key: 'club_id'     #memClub=member of club
  belongs_to :member, class_name: 'User' , foreign_key: 'user_id'
  #belongs_to :club
end
