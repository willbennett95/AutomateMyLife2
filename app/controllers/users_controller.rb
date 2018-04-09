class UsersController < ApplicationController
    
   def index
       @post = Posts.all
   end 
    
    
end