class Post < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true
  default_scope -> {order(created_at: :desc)} # shows newest posts first
  has_attached_file :image
  has_attached_file :image2
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
    validates_attachment_content_type :image2, content_type: /\Aimage\/.*\z/
end
