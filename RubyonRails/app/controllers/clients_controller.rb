class ClientsController < ApplicationController
    def new
      @client = Client.new
    end
  
    def create
      @client = Client.new(client_params)
      @emergency_contact = @client.emergency_contacts.build
  
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
        @clients = Client.all
      end
      
    def show
      @client = Client.find(params[:id])
    end
  
    private
    
    def client_params
        params.require(:client).permit(:first_name, :last_name, :email, :date_of_birth, :gender, :address1, :country, :state, :city, :zip, :phone1,:mgmt_ref,:phone2, emergency_contacts_attributes: [
          :first_name, :last_name, :phone, :address,
          :email, :city, :state
        ]
  )
      end
      
      
  end
  