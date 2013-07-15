# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  admin           :boolean
#

class User < ActiveRecord::Base
  require "open-uri"
  attr_accessible :name, :email, :password, :password_confirmation, :uid, :provider, :profile_pic 
  attr_accessor :profile_pic_file_name
  has_attached_file :profile_pic, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }
  has_secure_password


  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  
  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first || createFromOmniAuth(auth)
  end
  
  def picture_from_url(url)
    extname = File.extname(url)
    basename = File.basename(url, extname)

    file = Tempfile.new([basename, extname])
    file.binmode

    open(URI.parse(url)) do |data|  
      file.write data.read
    end

    file.rewind

    self.profile_pic = file
  end
  
  def self.createFromOmniAuth(auth)
    create! do |user|
    	user.provider = auth["provider"]
    	user.uid = auth["uid"]
    	user.name = auth["info"]["name"]
    	user.email = auth["info"]["email"]
    	user.password = "From Omniauth"
    	user.password_confirmation = "From Omniauth"
    	fb_url = "http://graph.facebook.com/#{user.uid}/picture?type=square"
    	user.picture_from_url fb_url
    end
  end
  
  private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
  
end
