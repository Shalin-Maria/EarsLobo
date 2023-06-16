class TestsController < ApplicationController




  # uses @dob to call the DOB from client and pass it so it can be used on test page
    def new
      @client = Client.find(params[:client_id])
      @test = @client.tests.build
      @dob = @client.date_of_birth
      
    end

    def new_dwt_list2
      @client = Client.find(params[:client_id])
      @test = @client.tests.build
      @dob = @client.date_of_birth
    end
    
    def new_dwt_list3
      @client = Client.find(params[:client_id])
      @test = @client.tests.build
      @dob = @client.date_of_birth
    end

    def new_dwt_list4
      @client = Client.find(params[:client_id])
      @test = @client.tests.build
      @dob = @client.date_of_birth
    end

    def new_dnw_list1
      @client = Client.find(params[:client_id])
      @test = @client.tests.build
      @dob = @client.date_of_birth
    end

    def new_dnw_list2
      @client = Client.find(params[:client_id])
      @test = @client.tests.build
      @dob = @client.date_of_birth
    end

    def new_dnw_list3
      @client = Client.find(params[:client_id])
      @test = @client.tests.build
      @dob = @client.date_of_birth
    end

    def new_dnw_list4
      @client = Client.find(params[:client_id])
      @test = @client.tests.build
      @dob = @client.date_of_birth
    end

    def new_rddt_list1
      @client = Client.find(params[:client_id])
      @test = @client.tests.build
      @dob = @client.date_of_birth
    end

    def new_rddt_list2
      @client = Client.find(params[:client_id])
      @test = @client.tests.build
      @dob = @client.date_of_birth
    end

    def edit
      @client = Client.find(params[:client_id])
      @test = Test.find(params[:id])
      render :edit
    end
    

    def update
      @client = Client.find(params[:client_id])
      @test = @client.tests.find(params[:id])
      @test.assign_attributes(test_params)
    
      if @test.save
        redirect_to edit_client_path(@client)
      else
        render 'edit'
      end
    end

  




def create
    @client = Client.find(params[:client_id])
    @test = @client.tests.build(test_params)
    @test.user = current_user
    @test.client = @client

    if @test.save

      redirect_to edit_client_path(@client)
    else
      render 'new'
    end
  end


  
    private
  
    def test_params
      params.require(:test).permit(:label, :notes, :client_name, :test_type, :left_score, :right_score, :ear_advantage, :ear_advantage_score, :scan, :authenticity_token)
    end
      
  end
  