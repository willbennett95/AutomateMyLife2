class IntermediatePostsController < ApplicationController
    def new 
        @iPost = intermediatePost.new
    end
    
    def create 
        @iPost = intermediatePost.new(intermediatePost_params)
        @iPost.user_id = current_user.id
        respond_to do |f|
            if (@iPost.save)
                f.html {redirect_to "", notice: "Post created"}
            else
                f.html {redirect_to "", notice: "Error: post was not saved"}
            end
        end
    end
    
    def show
        @user = User.find(params[:id])
    end
    
    def destroy
        @iPost = intermediatePost.find(params[:id])
        @iPost.destroy

        respond_to do |f|
            if (@iPost.destroy)
                f.html {redirect_to "", notice: "Post deleted"}
                f.json {head :no_content}
            else
                f.html {redirect_to "", notice: "Error: post was not deleted"}
            end
        end
    end
    
    private
    def intermediatePost_params 
        params.require(:intermediatePost).permit(:user_id, :content, :image)
    end     
end
