class AddLeftEarDecibelToClients < ActiveRecord::Migration[6.1]
  def change
    add_column :clients, :left_ear_decibel, :integer
  end
end
