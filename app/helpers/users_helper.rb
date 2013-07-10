module UsersHelper
  def gravatar_for(user, options = { size: 50 })
    if user.provider == nil 
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "img-circle")
    end 
    
    if user.provider == "facebook"
    size = options[:size]
    uid = user.uid
    fb_url = "http://graph.facebook.com/#{uid}/picture?type=square&width=#{size}&height=#{size}"
    image_tag(fb_url, alt: user.name, class: "polaroid-images")
    
    end
  end
end
