#ALLEARS ADDITION
 #app/controllers/audio_files_controller.rb
class AudioFilesController < ApplicationController
    def show
      file_name = "#{params[:file_name]}.wav"
      path_to_file = Rails.root.join('app', 'assets', 'audio', file_name)
  
      if File.exist?(path_to_file)
        send_file path_to_file, type: 'audio/wav', disposition: 'inline'
      else
        head :not_found
      end
    end
  end
  