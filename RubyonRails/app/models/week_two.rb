# == Schema Information
#
# Table name: week_twos
#
#  id                  :bigint           not null, primary key
#  client_name         :string
#  counter             :integer
#  ear_advantage       :string
#  ear_advantage_score :string
#  left_score          :string
#  notes               :text
#  right_score         :string
#  test_type           :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  tenant_id           :bigint
#  user_id             :bigint           not null
#
# Indexes
#
#  index_week_twos_on_tenant_id  (tenant_id)
#  index_week_twos_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (tenant_id => tenants.id)
#  fk_rails_...  (user_id => users.id)
#
class WeekTwo < ApplicationRecord
    acts_as_tenant(:tenant)
  
    belongs_to :client
    belongs_to :user
end
