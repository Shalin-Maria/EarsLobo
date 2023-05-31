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
        params.require(:test).permit(:label, :test_type, :client_name, :notes, :ear_advantage, :left_score, :right_score, :ear_advantage_score)
      end
      
  end
  