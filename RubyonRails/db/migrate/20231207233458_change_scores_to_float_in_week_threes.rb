class ChangeScoresToFloatInWeekThrees < ActiveRecord::Migration[6.1]
  def change
    change_column :week_threes, :left_score, :float, using: 'left_score::float'
    change_column :week_threes, :right_score, :float, using: 'right_score::float'
    change_column :week_threes, :ear_advantage_score, :float, using: 'ear_advantage_score::float'
  end
end
