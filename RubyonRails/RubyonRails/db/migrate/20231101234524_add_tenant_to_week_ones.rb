class AddTenantToWeekOnes < ActiveRecord::Migration[6.1]
  def change
    add_reference :week_ones, :tenant, foreign_key: true
  end
end
