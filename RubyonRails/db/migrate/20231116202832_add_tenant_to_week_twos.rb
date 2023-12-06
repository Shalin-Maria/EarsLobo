class AddTenantToWeekTwos < ActiveRecord::Migration[6.1]
  def change
    add_reference :week_twos, :tenant, foreign_key: true
  end
end
