class WeekTwosController < ApplicationController

    def rddt_week_two_test1
        @client = Client.find(params[:client_id])
        @week_two = @client.week_twos.build
       
    end
    def dwt_week_two_test2
      @client = Client.find(params[:client_id])
      @week_two = @client.week_twos.build
     end
     def dwt_week_two_test3 
      @client = Client.find(params[:client_id])
      @week_two = @client.week_twos.build
     end
     def dwt_week_two_test4
      @client = Client.find(params[:client_id])
      @week_two = @client.week_twos.build
     end
     def rddt_week_two_test5
      @client = Client.find(params[:client_id])
      @week_two = @client.week_twos.build
     
  end 
    def dnw_week_two_test6
        @client = Client.find(params[:client_id])
        @week_two = @client.week_twos.build
    end

    def dwt_week_two_test7
        @client = Client.find(params[:client_id])
        @week_two = @client.week_twos.build
    end
    def dwt_week_two_test8
      @client = Client.find(params[:client_id])
      @week_two = @client.week_twos.build
  end
    def index
        @week_twos = WeekTwos.all
        render :index
    end

    def show
      @client = Client.find(params[:client_id])
      @week_two = @client.week_twos.find(params[:id])

    end


    def edit
        @client = Client.find(params[:client_id])
        @week_two = WeekTwos.find(params[:id])
        render :edit
      end
      
  
      def update
        @client = Client.find(params[:client_id])
        @week_two = @client.week_ones.find(params[:id])
        @week_two.assign_attributes(week_two_params)
      
        if @week_one.save
          redirect_to edit_client_path(@client)
        else
          render 'edit'
        end
      end
  
    
  
  
  
  
  def create
      @client = Client.find(params[:client_id])
      @week_two = @client.week_ones.build(week_one_params)
      @week_two.user = current_user
      @week_two.client = @client
      submit_with_counter()
    end
    def submit_with_counter
      if @week_two.save
        case @week_two.counter
        when 1
          session[:test_one_completed] = true
          redirect_to week_two_test_two_client_week_twos_path(@client)
        when 2
          redirect_to week_two_test_three_client_week_twos_path(@client)
        when 3
          redirect_to week_two_test_four_client_week_twos_path(@client)
        when 4
          redirect_to week_two_test_five_client_week_twos_path(@client)
        when 5
          redirect_to week_two_test_six_client_week_twos_path(@client)
        when 6
          redirect_to week_two_test_seven_client_week_twos_path(@client)
        when 7
          redirect_to week_two_test_eight_client_week_twos_path(@client)
        when 8
          redirect_to client_trainings_path(@client)
        else
          render 'new'
        end
      else
        render 'new'
      end
    end
  
    
      private
    
      def week_one_params
        params.require(:week_two).permit( :notes, :client_name, :test_type, :left_score, :right_score, :ear_advantage, :ear_advantage_score, :counter)
      end

end
