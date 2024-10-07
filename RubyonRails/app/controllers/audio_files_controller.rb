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

  def play_audio(channel)
    # finds the latest temp file to play or plays default if not applicable
    Rails.logger.info("Attempting to play audio for channel: #{channel}")
    temp_file = find_latest_temp_file(channel)
    Rails.logger.info("Temp file found: #{temp_file || 'None'}")
    
    default_file = default_file(channel)
    Rails.logger.info("Default file found: #{default_file || 'None'}")
    
    # falls back to default if it can't find temp
    file = temp_file || default_file
    
    if file.nil?
      Rails.logger.error("No audio file found for channel: #{channel}")
      render json: { error: "No audio file found for #{channel} channel" }, status: :not_found
    elsif File.exist?(file)
      Rails.logger.info("Playing file: #{file}")
      file_name = File.basename(file)
      send_file file, type: 'audio/wav', disposition: 'inline', filename: file_name
    else
      Rails.logger.error("Audio file not found at path: #{file}")
      render json: { error: "Audio file not found for #{channel} channel" }, status: :not_found
    end
    
    # this is currently coded for .wav!!
  end

  def find_audio_file(channel)
    temp_file = find_latest_temp_file(channel)
    if temp_file && File.exist?(temp_file)
      Rails.logger.info "Using temp file for #{channel} channel: #{temp_file}"
      return temp_file
    end

    default_audio_file = find_default_file(channel)
    if default_audio_file
      Rails.logger.info "Using default file for #{channel} channel: #{default_audio_file}"
      return default_audio_file
    end

    Rails.logger.error "No audio file found for #{channel} channel"
    nil
  end

  # helper for finding the most recent file change for the respective ear channel/player
  def find_latest_temp_file(channel)
    pattern = Rails.root.join('tmp', "#{channel}_*.wav")
    latest_file = Dir.glob(pattern, File::FNM_CASEFOLD).max_by { |f| File.mtime(f) }
    if latest_file
      Rails.logger.info("Latest temp file for #{channel}: #{latest_file}")
    else
      Rails.logger.info("No temp file found for #{channel}. Searched pattern: #{pattern}")
    end
    latest_file
  end

  # This will be controlling the default file for each page, will need futher work and specifics on each view. Right now it is hardcoded.
  def default_file(channel)
    # ensures the channel is capitalized correctly
    capitalized_channel = channel.to_s.capitalize

    filename = "1-pair Dichotic Digits, List 1_#{capitalized_channel}_HRTF.wav"
  
    file_path = Rails.root.join('app', 'assets', 'audio', filename)

    Rails.logger.info("Searching for #{capitalized_channel} audio file: #{file_path}")
  
    if File.exist?(file_path)
      Rails.logger.info("Default file found for #{capitalized_channel}: #{file_path}")
      file_path
    else
      Rails.logger.error("No default file found for #{capitalized_channel}. Expected file: #{file_path}")
      nil
    end
  end
  
  # for adjusting decibels
  # currently hard coded audio!!!
  def adjust
    # play the altered file in respective channel OR play default when applicable
    left_input = params[:channel] == 'left' ? find_latest_temp_file('left') : default_file('left')
    right_input = params[:channel] == 'right' ? find_latest_temp_file('right') : default_file('right')

    left_file_name = left_input ? File.basename(left_input) : 'Not found'
    right_file_name = right_input ? File.basename(right_input) : 'Not found'
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

    Rails.logger.debug "Left adjusted audio analysis: #{left_analysis}"
    Rails.logger.debug "Right adjusted audio analysis: #{right_analysis}"

    cleanup_old_temp_files

    render json: { 
      left_url: url_for(action: 'play_left'),
      right_url: url_for(action: 'play_right'),
      left_file_name: left_file_name,
      right_file_name: right_file_name,
      left_analysis: left_analysis,
      right_analysis: right_analysis
    }
    # TODO make this show in console
  end

  # new method for audio adjustment to free it from being part of adjust, easier to edit
  def process_audio(input, decibel_change, apply_change)
    return nil unless input
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
    return nil unless file_path
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

    ['left', 'right'].each do |channel|
      Dir.glob(temp_dir.join("#{channel}_*.wav")).each do |file|
        if File.mtime(file) < threshold_time
          File.delete(file)
          Rails.logger.info "Deleted old temp file: #{file}"
        end
      end
    end
  end
end