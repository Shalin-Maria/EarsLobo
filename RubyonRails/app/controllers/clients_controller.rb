class ClientsController < ApplicationController
 before_action:authenticate_user!, except: [:index]  
  
  def new
      @client = Client.new
      @client.emergency_contacts.build
    end

  
    def create
      @client = Client.new(client_params)
  
      if @client.save
        flash[:success] = "client successfully added!"
        redirect_to clients_path, notice: "client created successfully."
      else
        flash.now[:error] = "client creation failed"
        render :new
      end
    end

    
    def edit
        @client = Client.find(params[:id])
      end


    def update
        @client = Client.find(params[:id])

        if @client.update(client_params)
            redirect_to clients_path, notice: "client updated successfully."
        else
            redirect_to edit_client_path(@client), notice: "client was not updated."
        end
    end
    def destroy
      @client = Client.find(params[:id])
      @client.destroy
  
      redirect_to clients_url, notice: "client was successfully deleted."
    end
  
    def index
      puts "Clients: #{Client.all.inspect}"
      if current_user.global_moderator?
        # For a global moderator, all clients are accessible
        client_scope = Client.unscoped.all
      else
        # For regular users, only clients of the same tenant are accessible
        client_scope = current_user.clients
      end
    
      if params[:query]
        split_query = params[:query].split(' ')
        if split_query.length > 1
          # Case when both first name and last name are typed
          @clients = client_scope.where('lower(first_name) LIKE :first AND lower(last_name) LIKE :last OR phone1 LIKE :query', 
                                      first: "#{split_query.first.downcase}%", 
                                      last: "#{split_query.last.downcase}%", 
                                      query: "%#{params[:query]}%")
        else
          # Case when either first name, last name, email, or phone number is typed
          @clients = client_scope.where('lower(first_name) LIKE :query OR lower(last_name) LIKE :query OR lower(email) LIKE :query OR phone1 LIKE :query', 
                                      query: "%#{params[:query].downcase}%")
        end
      else
        @clients = client_scope
      end
    end
    
    
      
    def show
      @client = Client.find(params[:id])
      @tests = @client.tests
      end
    def search
      if params[:search].blank?
        @clients = Client.all
      else
        @clients = Client.where("first_name ILIKE ? OR last_name ILIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
      end
    end
  end


  
  
    private
    
    def client_params
        params.require(:client).permit(:first_name, :last_name, :email, :date_of_birth, :gender, :address1, :country, :state, :city, :zip, :phone1,:mgmt_ref,:phone2, emergency_contacts_attributes: [
           :first_name, :last_name, :phone_number, :address,
          :email, :city, :state
        ]
  )
      end