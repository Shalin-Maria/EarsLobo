class AddClientToWeekTwos < ActiveRecord::Migration[6.1]
  def change
    add_reference :week_twos, :client, null: false, foreign_key: true
  end
end
