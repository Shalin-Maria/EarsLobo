class WeekFoursController < ApplicationController
    def dwt_week_four_test1
        @client = Client.find(params[:client_id])
        @week_four = @client.week_fours.build
    end

    def dwt_week_four_test2
      @client = Client.find(params[:client_id])
      @week_four = @client.week_fours.build
    end

    def rddt_week_four_test3
      @client = Client.find(params[:client_id])
      @week_four = @client.week_fours.build
    end

    def tales_week_four_test4
      @client = Client.find(params[:client_id])
      @week_four = @client.week_fours.build
    end

    def tales_week_four_test5
      @client = Client.find(params[:client_id])
      @week_four = @client.week_fours.build
    end
    def dnw_week_four_test6
      @client = Client.find(params[:client_id])
      @week_four = @client.week_fours.build
    end
    def dwt_week_four_test7
      @client = Client.find(params[:client_id])
      @week_four = @client.week_fours.build
    end
    def dwt_week_four_test8
      @client = Client.find(params[:client_id])
      @week_four = @client.week_fours.build
    end
    def rddt_week_four_test9
      @client = Client.find(params[:client_id])
      @week_four = @client.week_fours.build
    end

    def index
        @week_four = WeekFours.all
        render :index
    end

    def show
      @client = Client.find(params[:client_id])
      @week_four = @client.week_fours.find(params[:id])
    end


    def edit
        @client = Client.find(params[:client_id])
        @week_four = WeekFours.find(params[:id])
        render :edit
    end
      
  
    def update
      @client = Client.find(params[:client_id])
      @week_four = @client.week_fours.find(params[:id])
      @week_four.assign_attributes(week_four_params)
      
      if @week_four.save
        redirect_to edit_client_path(@client)
      else
        render 'edit'
      end
    end
  
  
    def create
      @client = Client.find(params[:client_id])
      @week_four = @client.week_fours.build(week_four_params)
      @week_four.user = current_user
      @week_four.client = @client
      submit_with_counter()
    end
  
    
    def submit_with_counter
      if @week_four.save
        case @week_four.counter
        when 1
          session[:test_one_completed] = true
          redirect_to week_four_test_two_client_week_fours_path(@client)
        when 2
          redirect_to week_four_test_three_client_week_fours_path(@client)
        when 3
          redirect_to week_four_test_four_client_week_fours_path(@client)
        when 4
          redirect_to week_four_test_five_client_week_fours_path(@client)
        when 5
          redirect_to week_four_test_six_client_week_fours_path(@client)
        when 6
          redirect_to week_four_test_seven_client_week_fours_path(@client)
        when 7
          redirect_to week_four_test_eight_client_week_fours_path(@client)
        when 8
          redirect_to week_four_test_nine_client_week_fours_path(@client)
        when 9
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
      def week_four_params
        params.require(:week_four).permit( :notes, :client_name, :test_type, :left_score, :right_score, :ear_advantage, :ear_advantage_score, :counter, :left_ear_decibel, :right_ear_decibel)
      end
end
