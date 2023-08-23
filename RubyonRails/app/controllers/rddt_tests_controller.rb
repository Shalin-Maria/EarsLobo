class RddtTestsController < ApplicationController

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

end
