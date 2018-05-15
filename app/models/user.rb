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
end
