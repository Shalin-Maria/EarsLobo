class TrainingsController < ApplicationController
    def index
        @client= Client.find(params[:client_id])
        @trainings = Training.all
        render :index
    end
    def show
        @client= Client.find(params[:client_id])
        @training= @client.trainings.find(params[:id])
        render :show
    end
end
