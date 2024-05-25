#ALLEARS ADDITION
 #app/controllers/audio_files_controller.rb
class AudioFilesController < ApplicationController
  
  #new for streamio-ffmpeg
  # Doing in javascript requires some jank, so trying it as a parameter call to this controller
  def adjust
    input_file = #TODO: Specify path
    output_file = #TODO: Set to same as input for overwrite

    #adjusting decibels by param, must be specified when the controller is called to change volume
    # ie POST /adjust_audo?decibel_change=10 would increase decibels by 10
    decibel_change = params[:decibel_change].to_f

    #this is the actual ffmpeg command
    #can be positive for increase, can pass negative for decrease
    #TODO: Add ear distinction? Could be added views side potentially?
    system("ffmpeg -i #{input_file} -filter:a \"volume=#{decibel_change}dB\" #{output_file}")

    # confirmation message for debugging and such
    render json: { message: 'Audio decibel level successfully changed'}
  end
end

=begin 
    old code, deprecated by gem change
  
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
=end
  