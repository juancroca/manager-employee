class Employee < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  has_and_belongs_to_many :teams
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :twitter_name, :facebook_name, :mobile, :phone, :team_ids, :uid
  #validates_presence_of :name, :twitter_name, :facebook_name, :if => :facebook_sign_up
  validates_numericality_of :mobile, :phone, :if => :facebook_sign_up
  
  def facebook_sign_up
    self.uid.blank?
  end

  def facebook_image
    "http://graph.facebook.com/#{self.uid}/picture?type=large"
  end
  
  def twitter_image(options={})
    Twitter.profile_image( self.twitter_name, options) unless self.twitter_name.blank?
  end

  def twitter_url
    "https://twitter.com/#{self.twitter_name}"
  end
  
  def facebook_url
    "https://facebook.com/#{self.facebook_name}"
  end

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    signed_in_resource.update_attributes(:uid => access_token[:uid], :name => data.name, :facebook_name => data.username)
    signed_in_resource
  end

  def self.new_with_session(params, session)
    super.tap do |employee|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        employee.email = data["email"]
      end
    end
  end

end
