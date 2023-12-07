class CreateWeekFours < ActiveRecord::Migration[6.1]
  def change
    create_table :week_fours do |t|
      t.string :test_type
      t.string :client_name
      t.text :notes
      t.string :ear_advantage
      t.string :left_score
      t.string :right_score
      t.string :ear_advantage_score
      t.integer :left_ear_decibel
      t.integer :right_ear_decibel
      t.integer :counter
      t.references :client, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :tenant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
