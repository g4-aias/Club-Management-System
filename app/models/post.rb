class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :club
  
  before_save :format_website_url
  
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  #validates :url, :format => URI::regexp(%w(http https)), presence: false
  validates :context,  presence: true, length: { maximum: 5000 }
  validates :title,  presence: true, length: { maximum: 100 }
  validates :user_id, presence: true
  validates :club_id, presence: true

  
########################################################################################
  
  private 
  
  def format_website_url
    unless url.blank?
      return if url.include?('http://') || url.include?('https://')
      self.url = "http://#{url}"
    end
  end
  
end
