class AddLeftEarDecibelToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :left_ear_decibel, :integer
  end
end
