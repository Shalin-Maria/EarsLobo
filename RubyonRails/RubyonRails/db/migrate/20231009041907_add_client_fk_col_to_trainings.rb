class AddClientFkColToTrainings < ActiveRecord::Migration[6.1]
  def change
    add_reference :trainings, :client, foreign_key: true
  end
end
