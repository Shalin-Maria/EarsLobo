class AddRightEarDecibelToClients < ActiveRecord::Migration[6.1]
  def change
    add_column :clients, :right_ear_decibel, :integer
  end
end
