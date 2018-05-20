class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])
    if @friendship.save
      flash[:notice] = "Friend request sent."
      redirect_to :back
    else
      flash[:error] = "Unable to add friend."
      redirect_to :back
    end
  end

  def update
    @friendship = Friendship.find_by(id: params[:id])
    @friendship.update(params[:accepted])
    if @friendship.save
      redirect_to root_url, notice: "Friend confirmed."
    else
      redirect_to root_url, notice: "Could not confirm friend."
    end
  end

  def destroy
    @friendship = Friendship.find_by(id: params[:id])
    @friendship.destroy
    flash[:notice] = "Friend deleted."
    redirect_to :back
  end
end
