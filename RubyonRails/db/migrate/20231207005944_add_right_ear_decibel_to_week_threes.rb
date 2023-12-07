class AddRightEarDecibelToWeekThrees < ActiveRecord::Migration[6.1]
  def change
    add_column :week_threes, :right_ear_decibel, :integer
  end
end
