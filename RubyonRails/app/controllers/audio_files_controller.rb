#ALLEARS ADDITION
 #app/controllers/audio_files_controller.rb
class AudioFilesController < ApplicationController
  #needed to avoid audio file clutter from constant adjustments!
  require 'tempfile'
  #new for streamio-ffmpeg
  # Doing in javascript requires some jank, so trying it as a parameter call to this controller

  def audio_testing
    # For rendering the view
    render 'debug/audio_testing'
  end
  # for playing the file
  def play
    # currently hardcoded for easy testing
    audio_file = Rails.root.join('app', 'assets', 'audio', '1-pair Dichotic Digits, List 1_Left_HRTF.wav')
    #TODO Make sure that the updated temp file is being player here (currently downloaded?) Need to un-hardcode this for further testing
    #debug to check for file being uploaded etc
    if File.exist?(audio_file)
      send_file audio_file, type: 'audio/wav', disposition: 'inline'
    else
      Rails.logger.error "Audio file not found: #{audio_file}"
      head :not_found
    end
    # this is currently coded for .wav!!
  end

  # for adjusting decibels
  # currently hard coded audio!!!
  def adjust
    input_file = Rails.root.join('app', 'assets', 'audio', '1-pair Dichotic Digits, List 1_Left_HRTF.wav')

    # Create a temporary file for the output
    output_file = Tempfile.new(['adjusted_audio', '.wav'])

    #adjusting decibels by param, must be specified when the controller is called to change volume
    # ie POST /adjust_audo?decibel_change=10 would increase decibels by 10
    decibel_change = params[:decibel_change].to_f

    # defining succes for debug
    command = "ffmpeg -i #{input_file} -filter:a \"volume=#{decibel_change}dB\" #{output_file.path}"
    success = system(command)

    #this is the actual ffmpeg command
    #can be positive for increase, can pass negative for decrease
    #TODO: Add ear distinction? Could be added views side potentially?

    # serves the adjusted audio file to the user's view page
    # currently downloads the value
    
    #TODO Find a good place to clean up the temporary file later when done

    #file change success debug
    if success
      send_file output_file.path, type: 'audio/wav', disposition: 'inline'
    else
      Rails.logger.error "FFmpeg command failed: #{command}"
      head :internal_server_error
    end
  rescue => e
    Rails.logger.error "Error in adjust method: #{e.message}"
    head :internal_server_error
  ensure
    output_file.close
    output_file.unlink
  end
    # This should hopefully allow for an AJAX request
    # this is a javascript responsea
    # this will likely bne needed for live update using buttons in the future
    #respond_to do |format|
    #  format.js
    #end
  
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
  