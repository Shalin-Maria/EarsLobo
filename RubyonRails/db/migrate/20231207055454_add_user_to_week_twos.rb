class AddUserToWeekTwos < ActiveRecord::Migration[6.1]
  def change
    add_reference :week_twos, :user, null: false, foreign_key: true
  end
end
