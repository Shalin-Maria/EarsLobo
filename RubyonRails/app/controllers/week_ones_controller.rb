class WeekOnesController < ApplicationController
    def new_week_one_test_five
        @client = Client.find(params[:client_id])
        @week_one = @client.week_ones.build
       
    end
    def new_week_one_test_six
        @client = Client.find(params[:client_id])
        @week_one = @client.week_ones.build
    end

    def rddt_week_one_test1
      @client = Client.find(params[:client_id])
      @week_one = @client.week_ones.build
    end

    def rddt_week_one_test2
      @client = Client.find(params[:client_id])
      @week_one = @client.week_ones.build
    end

    def dwt_week_one_test3
      @client = Client.find(params[:client_id])
      @week_one = @client.week_ones.build
    end

    def dwt_week_one_test4
      @client = Client.find(params[:client_id])
      @week_one = @client.week_ones.build
    end

    def new_week_one_test_seven
        @client = Client.find(params[:client_id])
        @week_one = @client.week_ones.build
    end
    def index
        @week_ones = WeekOnes.all
        render :index
    end

    def show
      @client = Client.find(params[:client_id])
      @week_one = @client.week_ones.find(params[:id])

    end


    def edit
        @client = Client.find(params[:client_id])
        @week_one = WeekOnes.find(params[:id])
        render :edit
      end
      
  
      def update
        @client = Client.find(params[:client_id])
        @week_one = @client.week_ones.find(params[:id])
        @week_one.assign_attributes(week_one_params)
      
        if @week_one.save
          redirect_to edit_client_path(@client)
        else
          render 'edit'
        end
      end
  
    
  
  
  
  
  def create
      @client = Client.find(params[:client_id])
      @week_one = @client.week_ones.build(week_one_params)
      @week_one.user = current_user
      @week_one.client = @client
  
      if @week_one.save
        redirect_to client_trainings_path(@client)
      else  
        render 'new'
      end
    end
  
  
    
      private
    #ALLEARS - L - added left and right ear decibel
      def week_one_params
        params.require(:week_one).permit( :notes, :client_name, :test_type, :left_score, :right_score, :ear_advantage, :ear_advantage_score, :left_ear_decibel, :right_ear_decibel)
      end

end
