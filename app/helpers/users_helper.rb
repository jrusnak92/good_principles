module UsersHelper
  def gravatar_for(user, options = { size: 50 })
    if user.provider = nil 
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "img-circle")
    
    else
    size = options[:size]
    fb_url = ""
    
    
    end
  end
end
