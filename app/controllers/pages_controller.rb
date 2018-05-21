class PagesController < ApplicationController
  def index
    @users = User.all
  end

  def home
    @posts = Post.all
    @newPost = Post.new

  end


  def profile
    # take the username as :id
    if(User.find_by_username(params[:id]))
      @username = params[:id]
    else
      redirect_to root_path, :notice => "User not found"
    end
    @posts = Post.all.where("user_id = ?", User.find_by_username(params[:id])) # only shows current user's posts on their profile
    @newPost = Post.new 
  end
  

  def connect
    @posts = Post.all
    @users = User.all
    
  end
end
