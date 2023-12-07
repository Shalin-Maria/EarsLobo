class CreateWeekTwos < ActiveRecord::Migration[6.1]
  def change
    create_table :week_twos do |t|
      t.string :client_name
      t.string :ear_advantage
      t.float :ear_advantage_score
      t.float :left_ear_decibel
      t.float :left_score
      t.text :notes
      t.float :right_ear_decibel
      t.float :right_score
      t.string :test_type

      t.timestamps
    end
  end
end
