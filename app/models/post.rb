class Post < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true
  default_scope -> {order(created_at: :desc)} # shows newest posts first
  has_attached_file :image
  has_attached_file :image2
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  validates_attachment_content_type :image2, content_type: /\Aimage\/.*\z/
  
  has_many :likes, dependent: :destroy
  
    cattr_accessor :current_user

  def self.to_csv
    attributes = %w{id content user_id created_at updated_at} 
    CSV.generate do |csv|
      csv << attributes
      all.each do |post|
        csv << post.attributes.values_at(*attributes)
      end
    end
  end


end
