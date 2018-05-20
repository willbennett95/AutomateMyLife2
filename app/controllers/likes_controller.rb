class LikesController < ApplicationController
    
   before_action :find_post
   before_action :find_like, only: [:destroy]
   
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
  
  private
  
  def find_post
    @post = Post.find(params[:post_id])
  end
  
  def already_liked?
      Like.where(user_id: current_user.id, post_id:
      params[:post_id]).exists?
  end
  
  def find_like
   @like = @post.likes.find(params[:id])
  end
    
end
