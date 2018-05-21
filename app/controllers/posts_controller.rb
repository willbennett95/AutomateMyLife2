class PostsController < ApplicationController

    def new 
        @post = Post.new
    end
    
    # Method for creating a new post
    def create
        @post = Post.new(post_params)
        @post.user_id = current_user.id
        respond_to do |f|
            if (@post.save)
                f.html {redirect_to "", notice: "Post created"}
            else
                f.html {redirect_to "", notice: "Error: post was not saved"}
            end
        end
    end
    
    # Find the post to display in the view
    def show
        @user = User.find(params[:id])
    end
    
    # Method for deleting a post
    def destroy
        @post = Post.find(params[:id])
        @post.destroy

        respond_to do |f|
            if (@post.destroy)
                f.html {redirect_to "", notice: "Post deleted"}
                f.json {head :no_content}
            else
                f.html {redirect_to "", notice: "Error: post was not deleted"}
            end
        end
    end

    # Method for exporting post data as a CSV file
    def index
     @posts = Post.all.where("user_id = ?", current_user.id)
     respond_to do |f|
       f.html
       f.csv { render text: @posts.to_csv }
     end
    end

    # Method for exporting post data as a PDF file
    def download_pdf
        @posts = Post.all.where("user_id = ?", current_user.id)
        pdf = WickedPdf.new.pdf_from_string(render_to_string('pages/profile.html.erb', layout: false))
        send_data pdf, :filename => "mydata.pdf", :type => "application/pdf", :disposition => "attachment"
    end
    
    # Helper methods
    private
            
    # Method defining what data is permitted in a post 
    def post_params 
        params.require(:post).permit(:user_id, :content, :image, :image2)
    end
    
end