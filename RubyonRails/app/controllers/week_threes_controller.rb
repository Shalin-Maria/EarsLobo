class WeekThreesController < ApplicationController
    def rddt_week_three_test1
        @client = Client.find(params[:client_id])
        @week_three = @client.week_threes.build
    end

    def tales_week_three_test2
      @client = Client.find(params[:client_id])
      @week_three = @client.week_threes.build
    end

    def tales_week_three_test3
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
      @week_three = @client.week_threes.build(week_three_params)
      @week_three.user = current_user
      @week_three.client = @client
      submit_with_counter()
    end
  
    
    def submit_with_counter
      if @week_three.save
        case @week_three.counter
        when 1
          session[:test_one_completed] = true
          redirect_to week_three_test_two_client_week_threes_path(@client)
        when 2
          redirect_to week_three_test_three_client_week_threes_path(@client)
        when 3
          redirect_to week_three_test_four_client_week_threes_path(@client)
        when 4
          redirect_to week_three_test_five_client_week_threes_path(@client)
        when 5
          redirect_to week_three_test_six_client_week_threes_path(@client)
        when 6
          redirect_to week_three_test_seven_client_week_threes_path(@client)
        when 7
          redirect_to week_three_test_eight_client_week_threes_path(@client)
        when 8
          redirect_to week_three_test_nine_client_week_threes_path(@client)
        when 9
          redirect_to week_three_test_ten_client_week_threes_path(@client)
        when 10
          redirect_to client_trainings_path(@client)
        else
          render 'new'
          #redirect_to client_trainings_path(@client)
        end
      else
        render 'new'
        #redirect_to client_trainings_path(@client)
      end
    end
  
    
      private
      #ALLEARS - L - added left and right ear decibel
      # took out :notes -->
      def week_three_params
        params.require(:week_three).permit( :notes, :client_name, :test_type, :left_score, :right_score, :ear_advantage, :ear_advantage_score, :counter, :left_ear_decibel, :right_ear_decibel)
      end
end
