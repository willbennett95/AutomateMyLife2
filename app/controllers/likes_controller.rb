class LikesController < ApplicationController
    
   before_action :find_post
   before_action :find_like, only: [:destroy]
   
  # Method to like a post
  def create
    respond_to do |f|
    if already_liked?
        f.html {redirect_to :back, notice: "Already liked."}
    else
        @post.likes.create(user_id: current_user.id)
    end
    f.html {redirect_to :back}
    end
  end
  
  # Method to unlike a post
  
  def destroy
    respond_to do |f|
    if !(already_liked?)
      f.html {redirect_to :back, notice: "Already unliked."}
    else
      @like.destroy
    end
    f.html {redirect_to :back}
    end
  end
  
  # Helper methods
  private
  
  # Find the post to like by ID
  def find_post
    @post = Post.find(params[:post_id])
  end
  
  # Check if the user has already liked the post
  def already_liked?
      Like.where(user_id: current_user.id, post_id: params[:post_id]).exists?
  end
  
  # Find the like by ID
  def find_like
   @like = @post.likes.find(params[:id])
  end
    
end
