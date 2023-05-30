class UsersController < ApplicationController
  def index
    if params[:query]
      split_query = params[:query].split(' ')
      if split_query.length > 1
        # Case when both first name and last name are typed
        @users = User.where('lower(fname) LIKE :first AND lower(lname) LIKE :last', 
                            first: "#{split_query.first.downcase}%", 
                            last: "#{split_query.last.downcase}%")
      else
        # Case when either first name, last name, or email is typed
        @users = User.where('lower(fname) LIKE :query OR lower(lname) LIKE :query OR lower(email) LIKE :query', 
                            query: "%#{params[:query].downcase}%")
      end
    else
      @users = User.all
    end
  end

end
