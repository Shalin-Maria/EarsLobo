class AddUserToWeekThrees < ActiveRecord::Migration[6.1]
  def change
    add_reference :week_threes, :user, null: false, foreign_key: true
  end
end
