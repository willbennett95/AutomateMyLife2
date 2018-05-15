class AddAttachmentImageToIntermediatePosts < ActiveRecord::Migration
  def self.up
    change_table :intermediate_posts do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :intermediate_posts, :image
  end
end
