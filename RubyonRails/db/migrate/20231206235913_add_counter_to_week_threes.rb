class AddCounterToWeekThrees < ActiveRecord::Migration[6.1]
  def change
    add_column :week_threes, :counter, :integer
  end
end
