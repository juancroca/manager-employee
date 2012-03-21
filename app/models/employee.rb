class Employee < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  has_and_belongs_to_many :teams
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :twitter_name, :facebook_name, :mobile, :phone, :team_ids
  validates_presence_of :name, :twitter_name, :facebook_name
  validates_numericality_of :mobile, :phone 
  def twitter_image(options={})
    Twitter.profile_image( self.twitter_name, options)
  end
  
  def twitter_url
    "https://twitter.com/#{self.twitter_name}"
  end
  
  def facebook_url
    "https://facebook.com/#{self.twitter_name}"
  end

end
