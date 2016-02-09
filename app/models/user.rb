class User < ActiveRecord::Base
  
    has_many :clubs
    has_many :modClubs, through: :moderations
    has_many :moderations, dependent: :destroy
    has_many :posts
    has_many :memClubs, through: :memberships
    has_many :memberships, dependent: :destroy
    has_many :mod_requests
    has_many :club_requests, through: :member_requests
    has_many :member_requests
    has_many :comments

    
    attr_accessor :remember_token, :activation_token, :reset_token, :terms
    before_save   :downcase_email
    #before_save   :format_email
    before_create :create_activation_digest
    
  
    has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100#" }, :default_url => "missing.png"
    validates_attachment_content_type :avatar, :content_type => %w(image/jpeg image/jpg image/png)
    
    
    validates :firstname,  length: { maximum: 30 }
    validates :lastname,  length: { maximum: 30 }
    validates :name,  presence: true, length: { maximum: 20 },
                        uniqueness: { case_sensitive: false }
    
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 50 },
                        uniqueness: { case_sensitive: false },
                        format: {with: VALID_EMAIL_REGEX}
                      
    validates :phone, length: {maximum: 10}
    
    validates :terms, acceptance: true
                        
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
    
  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  # Returns the hash digest of the given string.
#  def self.digest(string)
#    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
#                                                  BCrypt::Engine.cost
#    BCrypt::Password.create(string, cost: cost)
#  end

  # Returns a random token.
#  def self.new_token
#    SecureRandom.urlsafe_base64
#  end
  
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  # Returns true if the given token matches the digest.
#  def authenticated?(remember_token)
#    return false if remember_digest.nil?
#    BCrypt::Password.new(remember_digest).is_password?(remember_token)
#  end
  
   # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
  
  # Find user by username
  def self.by_username_insensitive(name)
    User.where('LOWER(name) = ?', name.downcase).first
  end
  
   # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end
  
  # Activates an account.
  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end
  
  # Sends activation email.
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end
  
  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end
  
  # Returns true if a password reset has expired.
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end
  
  
  private
  
  # Converts email to all lower-case.
    def downcase_email
      self.email = email.downcase
    end

    # Creates and assigns the activation token and digest.
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
    
    #sets user email before saving
    def format_email
      return if email.include?('@sfu.ca')
      self.email = "#{email}@sfu.ca"
    end
end
