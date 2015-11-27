class Post < ActiveRecord::Base
  
  acts_as_votable
  belongs_to :user
  belongs_to :club
  has_many :comments, dependent: :destroy
  
  before_save :format_website_url
  before_save :scrape_with_grabbit

  default_scope -> { order(created_at: :desc) }
  #mount_uploader :picture, PictureUploader
  #validates :url, :format => URI::regexp(%w(http https)), presence: false
  validates :context,  presence: true, length: { maximum: 5000 }
  validates :title,  presence: true, length: { maximum: 100 }
  validates :user_id, presence: true
  validates :club_id, presence: true

  validates_presence_of :option, :if => ["true","false"]


  has_attached_file :image, styles: { medium: "300x300>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  
  def is_owner?(user)
    user.id == user_id
  end
  
  private 
  
  def format_website_url
    unless url.blank?
      return if url.include?('http://') || url.include?('https://')
      self.url = "http://#{url}"
    end
  end
  
  def scrape_with_grabbit
    unless url.blank?
      data = Grabbit.url(url)
      self.context = data.description 
      self.picture = data.images.first
    end
  end
  
  def set_time_to_nil
    if self.option == "true"
      self.start_time = nil
    end
  end

  
end
