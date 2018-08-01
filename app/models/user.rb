class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
    has_many :posts, dependent: :destroy # one user can have many posts, and if a user is deleted, delete their posts
    has_many :likes
    has_many :active_followers, class_name: "Follower", foreign_key: "follower_id", dependent: :destroy
    has_many :passive_followers, class_name: "Follower", foreign_key: "followed_id", dependent: :destroy
    has_many :following, through: :active_followers, source: :followed
    has_many :followers, through: :passive_followers, source: :follower
    
      has_attached_file :profilepic, styles: { medium:"500x500#", thumb: "50x50#" }, :default_url => "/images/:style/default_profile.jpg"
      validates_attachment_content_type :profilepic, content_type: /\Aimage\/.*\Z/
      validates_attachment_file_name :profilepic, matches: [/png\Z/, /PNG\Z/, /jpe?g\Z/, /JPE?G\Z/] # Users can only send the specified file types to the database
      
    # checks if a post has any likes 
    def likes?(post)
      post.likes.where(user_id: id).any?
    end
    
    # follow a user
    def follow(user)
      active_followers.create(followed_id: user.id)
    end
    
    # unfollow a user
    def unfollow(user)
      active_followers.find_by(followed_id: user.id).destroy
    end
    
    # check if a user is following another user
    def following?(user)
      following.include?(user)
    end
    
end
