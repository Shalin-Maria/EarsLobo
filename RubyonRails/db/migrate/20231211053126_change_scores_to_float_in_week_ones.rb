class ChangeScoresToFloatInWeekOnes < ActiveRecord::Migration[6.1]
  def change
    change_column :week_ones, :left_score, :float, using: 'left_score::float'
    change_column :week_ones, :right_score, :float, using: 'right_score::float'
    change_column :week_ones, :ear_advantage_score, :float, using: 'ear_advantage_score::float'
  end
end
