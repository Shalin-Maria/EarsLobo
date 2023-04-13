class CreateEmergencyContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :emergency_contacts do |t|
      t.string :address
      t.string :city
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :phone_number
      t.string :state

      t.timestamps
    end
    add_reference :emergency_contacts, :client, foreign_key: true

  end
end
