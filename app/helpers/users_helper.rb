module UsersHelper  
    
    def correct_user
        user == current_user
    end

end