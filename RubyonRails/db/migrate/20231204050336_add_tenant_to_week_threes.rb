class AddTenantToWeekThrees < ActiveRecord::Migration[6.1]
  def change
    add_reference :week_threes, :tenant, foreign_key: true
  end
end
