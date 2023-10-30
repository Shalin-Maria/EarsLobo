class CreateTrainings < ActiveRecord::Migration[6.1]
  def change
    create_table :trainings do |t|
      t.integer :week
      t.string :client_name
      t.string :ear_advantage
      t.string :ear_advanatage_score
      t.string :left_score
      t.string :right_score

      t.timestamps
    end
  end
end
