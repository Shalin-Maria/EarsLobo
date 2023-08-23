class DnwTestsController < ApplicationController
    
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
    
end
