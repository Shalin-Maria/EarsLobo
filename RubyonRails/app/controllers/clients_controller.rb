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
      # Determine the scope based on the user role
      if current_user.global_moderator?
        # For a global moderator, all clients are accessible
        client_scope = Client.unscoped
      else
        # For regular users, only clients of the same tenant are accessible
        client_scope = current_user.clients.where(tenant_id: current_user.tenant_id)
      end

      # Set the selected sorting option based on params
      selected_sorting_name = params[:q]&.dig(:sort_by_name)
      selected_sort_by_client = params[:q]&.dig(:sort_by_client)
      selected_sort_by_date_birth = params[:q]&.dig(:sort_by_date_birth)
    
      # Initialize Ransack search object with the given scope
      @q = client_scope.ransack(params[:q])
    
      # Set the sorting option based on the parameter
      if selected_sorting_name || selected_sort_by_client || selected_sort_by_date_birth
        @q.sorts = selected_sorting_name
        @q.sorts = selected_sort_by_client
        @q.sorts = selected_sort_by_date_birth
      end

      # Code below is used to allow user to filter clients on age, broken for now. FIX ME
      #   # Filter by age range
    # age_gteq = params[:q]&.dig(:age_gteq)
    # age_eq = params[:q]&.dig(:age_eq)
    # age_lteq = params[:q]&.dig(:age_lteq)

    # if age_gteq.present? && age_lteq.present?
    #   @q.result = @q.result.where("age_in_years >= ? AND age_in_years <= ?", age_gteq, age_lteq)
    # elsif age_gteq.present?
    #   @q.result = @q.result.where("age_in_years >= ?", age_gteq)
    # elsif age_eq.present?
    #   @q.result = @q.result.where(age_in_years: age_eq)
    # elsif age_lteq.present?
    #   @q.result = @q.result.where("age_in_years <= ?", age_lteq)
    # end

      # Execute the search query, ensuring distinct results
      @clients = @q.result(distinct: true)
    
      respond_to do |format|
        format.html
        format.csv { send_data generate_csv(@clients), filename: "client_data-#{Date.today}.csv" }
      end
        # Regular users can only access clients in their tenant
        client_scope = Client.where(tenant_id: current_user.tenant_id)
      end
    
    
    end
    
      
    def show
      @client = Client.find(params[:id])
      @tests = @client.tests
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
  