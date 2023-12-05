class WeekThreesController < ApplicationController
    def rddt_week_three_test1
        @client = Client.find(params[:client_id])
        @week_three = @client.week_threes.build
    end

    def dwt_week_three_test4
      @client = Client.find(params[:client_id])
      @week_three = @client.week_threes.build
    end

    def dwt_week_three_test5
      @client = Client.find(params[:client_id])
      @week_three = @client.week_threes.build
    end

    def dnw_week_three_test6
      @client = Client.find(params[:client_id])
      @week_three = @client.week_threes.build
    end

    def dnw_week_three_test7
      @client = Client.find(params[:client_id])
      @week_three = @client.week_threes.build
    end

    def rddt_week_three_test8
      @client = Client.find(params[:client_id])
      @week_three = @client.week_threes.build
    end

    def dwt_week_three_test9
      @client = Client.find(params[:client_id])
      @week_three = @client.week_threes.build
    end

    def dwt_week_three_test10
      @client = Client.find(params[:client_id])
      @week_three = @client.week_threes.build
    end
    
    def index
        @week_three = WeekThrees.all
        render :index
    end

    def show
      @client = Client.find(params[:client_id])
      @week_three = @client.week_threes.find(params[:id])

    end


    def edit
        @client = Client.find(params[:client_id])
        @week_three = WeekThrees.find(params[:id])
        render :edit
      end
      
  
      def update
        @client = Client.find(params[:client_id])
        @week_three = @client.week_threes.find(params[:id])
        @week_three.assign_attributes(week_three_params)
      
        if @week_three.save
          redirect_to edit_client_path(@client)
        else
          render 'edit'
        end
      end
  
    
  
  
  
  
  def create
      @client = Client.find(params[:client_id])
      @week_three = @client.week_threes.build(week_one_params)
      @week_three.user = current_user
      @week_three.client = @client
  
      if @week_three.save
  
        redirect_to edit_client_path(@client)
      else
        render 'new'
      end
    end
  
  
    
      private

      # took out :notes -->
      def week_one_params
        params.require(:week_three).permit(:client_name, :test_type, :left_score, :right_score, :ear_advantage, :ear_advantage_score)
      end
end
