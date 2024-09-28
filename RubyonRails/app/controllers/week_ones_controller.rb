class WeekOnesController < ApplicationController
    
    def rddt_week_one_test1
      #Layton Testing Additions
      # Initialize @week_one with parameters for a new record or find an existing one
      @client = Client.find(params[:client_id])

      # This SHOULD trigger when a POST (form submission) occurs
      if request.post?
        @week_one = @client.week_ones.build(week_one_params)
        # Set additional attributes if necessary
        # all right side of equal need to be defined for submission, might need additions to training view page itself for this
        @week_one.user = current_user 
        # This SHOULD occur if we save week_one. It redirects to the next test, 
        if @week_one.save
          # WIP: REDIRECT NEEDS ACTUAL PATH CORRECTED - CURRENTLY JUST FOR EXAMPLE -Redirect to the next test or a confirmation page on success
          # try to use their counter implementations? Probably won't work as is.
          # redirect_to submit_with_counter, 
          redirect_to submit_with_counter, notice: 'Test 1 saved successfully.'
        else
          # Render the form again with errors
          render :new
        end
      else @week_one = @client.week_ones.build
      end
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

    def dwt_week_one_test5
      @client = Client.find(params[:client_id])
      @week_one = @client.week_ones.build
    end

    def dnw_week_one_test6
      @client = Client.find(params[:client_id])
      @week_one = @client.week_ones.build
    end

    def dnw_week_one_test7
      @client = Client.find(params[:client_id])
      @week_one = @client.week_ones.build
    end

    def dwt_week_one_test8
      @client = Client.find(params[:client_id])
      @week_one = @client.week_ones.build
    end

    def rddt_week_one_test9
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
      
    #def update
      #@client = Client.find(params[:client_id])
      #@week_one = @client.week_ones.find(params[:id])
      #@week_one.assign_attributes(week_one_params)
      def edit
        @client = Client.find(params[:client_id])
        @week_one = WeekOne.find(params[:id])  # Changed WeekOnes to WeekOne
        render :edit
      
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
      submit_with_counter()
    end
    
    def submit_with_counter
      if @week_one.save
        case @week_one.counter
        when 1
          session[:test_one_completed] = true
          redirect_to week_one_test_two_client_week_ones_path(@client)
        when 2
          redirect_to week_one_test_three_client_week_ones_path(@client)
        when 3
          redirect_to week_one_test_four_client_week_ones_path(@client)
        when 4
          redirect_to week_one_test_five_client_week_ones_path(@client)
        when 5
          redirect_to week_one_test_six_client_week_ones_path(@client)
        when 6
          redirect_to week_one_test_seven_client_week_ones_path(@client)
        when 7
          redirect_to week_one_test_eight_client_week_ones_path(@client)
        when 8
          redirect_to week_one_test_nine_client_week_ones_path(@client)
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
      def week_one_params
        params.require(:week_one).permit( :notes, :client_name, :test_type, :left_score, :right_score, :ear_advantage, :ear_advantage_score, :counter, :left_ear_decibel, :right_ear_decibel)
      end

end
