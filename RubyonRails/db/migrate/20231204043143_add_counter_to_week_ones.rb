class AddCounterToWeekOnes < ActiveRecord::Migration[6.1]
  def change
    add_column :week_ones, :counter, :integer
  end
end
