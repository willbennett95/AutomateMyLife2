class UsersController < ApplicationController
    
   def index
       @post = Posts.all
       @users = User.all
   end 
    
    
end