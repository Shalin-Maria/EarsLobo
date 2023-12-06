class AddRightEarDecibelToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :right_ear_decibel, :integer
  end
end
