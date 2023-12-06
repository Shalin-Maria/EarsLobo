class AddLeftEarDecibelToWeekOnes < ActiveRecord::Migration[6.1]
  def change
    add_column :week_ones, :left_ear_decibel, :integer
  end
end
