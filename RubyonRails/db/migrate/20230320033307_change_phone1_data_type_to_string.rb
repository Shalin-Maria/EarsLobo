class ChangePhone1DataTypeToString < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :phone1, :string
  end
end
