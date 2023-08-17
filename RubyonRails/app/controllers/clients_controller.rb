class ClientsController < ApplicationController
 before_action:authenticate_user!, except: [:index]  
 require 'csv'
  
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
        id = params[:test_id]
        @test = @client.tests.find_by(params[id: id])
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
        client_scope = current_user.clients.where(tenant_id: current_user.tenant_id)
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
      respond_to do |format|
        format.html
        format.csv { send_data generate_csv(@clients), filename: "client_data-#{Date.today}.csv" }
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
  def global_moderator_index
    if current_user.global_moderator?
      @clients = Client.includes(:tests).all

      respond_to do |format|
        format.html
        format.csv { send_data generate_csv(@clients), filename: "global_moderator_data-#{Date.today}.csv" }
      end
    
    else
      # If the user is not a global moderator, redirect them
      redirect_to root_path, alert: 'You do not have access to this page.'
    end
  end
end



def generate_csv(clients)
  if current_user.global_moderator?
    return CSV.generate(headers: true) do |csv|
      csv << ["Gender", "Age", "City", "Country", "State", "Race", "Ear Advantage", "Ear Advantage Score", "Left Score", "Right Score"]

      clients.each do |client|
        client.tests.each do |test|
          csv << [client.gender, client.age_in_years, client.city, client.country, client.state, client.race, test.ear_advantage, test.ear_advantage_score, test.left_score, test.right_score]
        end
      end
    end

  else
    return CSV.generate(headers: true) do |csv|
      csv << ["First Name", "Last Name", "Gender", "Email", "Date of Birth", "Phone", "Address", "tenant_id"]

      clients.each do |client|
        csv << [client.first_name, client.last_name, client.gender, client.email, client.date_of_birth, client.phone1, client.address1, client.tenant_id]
      end
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