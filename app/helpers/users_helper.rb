module UsersHelper
    # Returns the Gravatar for the given user.
  def gravatar_for(user, options = { size: 50 }) 
  gravatar_id = Digest::MD5::hexdigest(user.email.downcase) #그라바타는  MD5 hash 이용
  size = options[:size]
  gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
  image_tag(gravatar_url, alt: user.name, class: "gravatar")
end
end
