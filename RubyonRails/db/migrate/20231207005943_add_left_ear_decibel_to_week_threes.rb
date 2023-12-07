class AddLeftEarDecibelToWeekThrees < ActiveRecord::Migration[6.1]
  def change
    add_column :week_threes, :left_ear_decibel, :integer
  end
end
