class Moderation < ActiveRecord::Base
  #belongs_to :club
  belongs_to :modClub, class_name: 'Club' , foreign_key: 'club_id'
  belongs_to :moderator, class_name: 'User' , foreign_key: 'user_id'
  #belongs_to :user
end
