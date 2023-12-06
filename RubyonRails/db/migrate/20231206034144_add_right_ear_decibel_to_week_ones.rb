class AddRightEarDecibelToWeekOnes < ActiveRecord::Migration[6.1]
  def change
    add_column :week_ones, :right_ear_decibel, :integer
  end
end
