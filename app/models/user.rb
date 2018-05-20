class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
    has_many :posts, dependent: :destroy # one user can have many posts, and if a user is deleted, delete their posts
    has_many :intermediatePosts, dependent: :destroy
      has_attached_file :profilepic, styles: { medium:"500x500#", thumb: "50x50#" }, :default_url => "/images/:style/default_profile.jpg"
      validates_attachment_content_type :profilepic, content_type: /\Aimage\/.*\Z/
      validates_attachment_file_name :profilepic, matches: [/png\Z/, /PNG\Z/, /jpe?g\Z/, /JPE?G\Z/]
      
    has_many :likes

    def likes?(post)
      post.likes.where(user_id: id).any?
    end
      
  	has_many :friendships
  	has_many :received_friendships, class_name: "Friendship", foreign_key: "friend_id"
  
  	has_many :active_friends, -> { where(friendships: { accepted: true}) }, through: :friendships, source: :friend
  	has_many :received_friends, -> { where(friendships: { accepted: true}) }, through: :received_friendships, source: :user
  	has_many :pending_friends, -> { where(friendships: { accepted: false}) }, through: :friendships, source: :friend
  	has_many :requested_friendships, -> { where(friendships: { accepted: false}) }, through: :received_friendships, source: :user
  
  	def friends
  	  active_friends | received_friends
  	end
  
  	def pending
  		pending_friends | requested_friendships
  	end
end
