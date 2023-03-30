class RenameUserIdToClientIdInEmergencyContacts < ActiveRecord::Migration[6.1]
  def change
    rename_column :emergency_contacts, :user_id, :client_id
  end
end
