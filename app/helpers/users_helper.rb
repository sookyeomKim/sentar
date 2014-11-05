module UsersHelper
    # Returns the Gravatar for the given user.
    def gravatar_for(user, options = { size: 50 }) 
  gravatar_id = Digest::MD5::hexdigest(user.email.downcase) #그라바타는  MD5 hash 이용
  size = options[:size]
  gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
  image_tag(gravatar_url, alt: user.name)
end

def gravatar_for_circle(user, options = { size: 50 })
  	gravatar_id = Digest::MD5::hexdigest(user.email.downcase) #그라바타는  MD5 hash 이용
  	size = options[:size]
  	gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
  	image_tag(gravatar_url, alt: user.name,class:"img-circle")
  end

  def gravatar_for_circle2(user, options = { size: 50 })
  	gravatar_id = Digest::MD5::hexdigest(user.email.downcase) #그라바타는  MD5 hash 이용
  	size = options[:size]
  	gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
  	image_tag(gravatar_url, alt: user.name,style:"border-radius:5px;")
  end  
end
