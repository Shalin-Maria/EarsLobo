class AddUserToWeekOnes < ActiveRecord::Migration[6.1]
  def change
    add_reference :week_ones, :user, null: false, foreign_key: true
  end
end
