class TestsController < ApplicationController
    def new
      @client = Client.find(params[:client_id])
      @test = @client.tests.build

    end
  
    def create
      @client = Client.find(params[:client_id])
      @test = @client.tests.build(test_params)
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
  