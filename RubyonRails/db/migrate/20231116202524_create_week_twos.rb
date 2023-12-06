class CreateWeekTwos < ActiveRecord::Migration[6.1]
  def change
    create_table :week_twos do |t|
      t.string :test_type
      t.string :client_name
      t.text :notes
      t.string :ear_advantage
      t.string :left_score
      t.string :right_score
      t.string :ear_advantage_score

      t.timestamps
    end
  end
end
