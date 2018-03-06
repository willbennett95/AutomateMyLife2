class PagesController < ApplicationController
  def index
  end

  def home
  end

  def profile
    
    # take the username as :id
    if(User.find_by_username(params[:id]))
      @username = params[:id]
    else
      redirect_to root_path, :notice => "User not found"
    end
    
  end

  def explore
  end
end
