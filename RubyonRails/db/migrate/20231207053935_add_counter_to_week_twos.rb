class AddCounterToWeekTwos < ActiveRecord::Migration[6.1]
  def change
    add_column :week_twos, :counter, :integer
  end
end
