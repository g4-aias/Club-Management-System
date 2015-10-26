class User < ActiveRecord::Base
    before_save { self.email = email.downcase }
    validates :firstname,  presence: true, length: { maximum: 15 }
    validates :lastname,  presence: true, length: { maximum: 15 }
    validates :name,  presence: true, length: { maximum: 15 },
                        uniqueness: { case_sensitive: false }
    
    validates :email, presence: true, length: { maximum: 250 },
                        uniqueness: { case_sensitive: false }
                 
                        
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }
end
