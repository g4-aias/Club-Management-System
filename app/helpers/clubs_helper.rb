module ClubsHelper
  #def build_club_path(club)
    #view_club_path(path: club.path)
  #end
    # Returns the Gravatar for the given user.
  def gravatar_forc(club, options = { size: 120 })
    gravatar_id = Digest::MD5::hexdigest(club.name)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: club.name, class: "gravatar")
  end
  

  
end
