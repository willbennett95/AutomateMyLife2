class FollowersController < ApplicationController
    
    # Method for following a user
    def create
        user = User.find(params[:followed_id])
        current_user.follow(user)
        redirect_to(:back)
    end
    
    # Method for unfollowing a user
    def destroy
        user = Follower.find(params[:id]).followed
        current_user.unfollow(user)
        redirect_to(:back)
    end
    
end
