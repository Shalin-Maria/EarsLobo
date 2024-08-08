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

  # For playing in the 'left ear' player
  def play_left
    play_audio('left')
  end

  # For playing in the 'right ear' player
  def play_right
    play_audio('right')
  end

  private

  def play_audio(channel)
    # finds the latest temp file to play

    file = find_latest_temp_file(channel) || default_file(channel)
    send_file file, type: 'audio/wav', disposition: 'inline'
    
    # this is currently coded for .wav!!
  end

  # helper for finding the most recent file change for the respective ear channel/player
  def find_latest_temp_file(prefix)
    Dir.glob(Rails.root.join('tmp', "#{prefix}_*.wav")).max_by { |f| File.mtime(f) }
  end

  # This will be controlling the default file for each page, will need futher work and specifics on each view. Right now it is hardcoded.
  def default_file(channel)
    #
    Rails.root.join('app', 'assets', 'audio', "1-pair Dichotic Digits, List 1_#{channel}_HRTF.wav")
  end
  
  # for adjusting decibels
  # currently hard coded audio!!!
  def adjust

    left_input = params[:channel] == 'left' ? find_latest_temp_file('left') : default_file('left')
    right_input = params[:channel] == 'right' ? find_latest_temp_file('right') : default_file('right')

    # Generates a unique filename for the new file
    # output_filename = "adjusted_audio_#{Time.now.to_i}_#{rand(1000)}.wav"
    # Create a temporary file for the output
    #output_file = Rails.root.join('tmp', output_filename)

    #adjusting decibels by param, must be specified when the controller is called to change volume
    # ie POST /adjust_audo?decibel_change=10 would increase decibels by 10
    decibel_change = params[:decibel_change].to_f
    channel = params[:channel]

    left_output = process_audio(left_input, decibel_change, channel == 'left')
    right_output = process_audio(right_input, decibel_change, channel == 'right')

      #this hooks into our method for debugging/checking decibel change
      #original_analysis = analyze_audio(input_file)
      left_analysis = analyze_audio(left_output)
      right_analysis = analyze_audio(right_output)

      Rails.logger.debug "Original audio analysis: #{original_analysis}"
      Rails.logger.debug "Left adjusted audio analysis: #{left_analysis}"
      Rails.logger.debug "Right adjusted audio analysis: #{right_analysis}"

      cleanup_old_temp_files

      render json: { 
      left_url: url_for(controller: 'audio_files', action: 'play_left'),
      right_url: url_for(controller: 'audio_files', action: 'play_right'),
      left_analysis: left_analysis,
      right_analysis: right_analysis
      }
      # TODO make this show in console
      
  end

  # new method for audio adjustment to free it from being part of adjust, easier to edit
  def process_audio(input, decibel_change, apply_change)
    # generates a random new file name
    output = Rails.root.join('tmp', "#{File.basename(input, '.*')}_#{Time.now.to_i}_#{rand(1000)}.wav")
    # changes the decibels based on the passed value for that new file
    filter = apply_change ? "volume=#{decibel_change}dB" : 'anull'
    system("ffmpeg", "-i", input.to_s, "-filter:a", filter, output.to_s)
    output
  end
    # This should hopefully allow for an AJAX request
    # this is a javascript responsea
    # this will likely bne needed for live update using buttons in the future
    #respond_to do |format|
    #  format.js
    #end
  
    # This is for testing that the decibels are being change appropriately!
    def analyze_audio(file_path)

      command = "ffmpeg -i \"#{file_path}\" -af volumedetect -f null /dev/null 2>&1"
  
  
      Rails.logger.debug "Analysis command: #{command}"

      output = `#{command}`

      mean_volume = output.match(/mean_volume: ([-\d.]+) dB/)&.captures&.first
      max_volume = output.match(/max_volume: ([-\d.]+) dB/)&.captures&.first

      # TODO: make sure this ruby hash is showing in console
      { mean_volume: mean_volume, max_volume: max_volume }


    end

    # Handles cleanup of temp files the site no longer needs to avoid file bloat
    def cleanup_old_temp_files
      temp_dir = Rails.root.join('tmp')
      threshold_time = 1.hour.ago
  
      Dir.glob(temp_dir.join('left_*')).each do |file|
        File.delete(file) if File.mtime(file) < threshold_time
      end

      Dir.glob(temp_dir.join('right_*')).each do |file|
        File.delete(file) if File.mtime(file) < threshold_time
      end
    end
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
  