class WeekTwosController < ApplicationController
end
class WeekOnesController < ApplicationController
    def new_week_two_test_five
        @client = Client.find(params[:client_id])
        @week_two = @client.week_twos.build
       
    end
    def new_week_two_test_six
        @client = Client.find(params[:client_id])
        @week_two = @client.week_twos.build
    end

   

    def new_week_two_test_seven
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
  
      if @week_two.save
        redirect_to client_trainings_path(@client)
      else  
        render 'new'
      end
    end
  
  
    
      private
    
      def week_one_params
        params.require(:week_two).permit( :notes, :client_name, :test_type, :left_score, :right_score, :ear_advantage, :ear_advantage_score)
      end

end
