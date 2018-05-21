class FriendRequestsController < ApplicationController
    
  before_action :set_friend_request, except: [:index, :create]

  def create
    respond_to do |f|
        friend = User.find(params[:friend_id])
        @friend_request = current_user.friend_requests.new(friend: friend)
    
        if @friend_request.save
          f.html {redirect_to :back, notice: "Added."}
        else
          render json: @friend_request.errors, status: :unprocessable_entity
        end
    end
  end
  
  def update
    @friend_request.accept
    head :no_content
  end
  
  def index
    @incoming = FriendRequest.where(friend: current_user)
    @outgoing = current_user.friend_requests
  end
  
  def destroy
    @friend_request.destroy
    head :no_content
  end
  
  private

  def set_friend_request
    @friend_request = FriendRequest.find(params[:id])
  end
    
end
