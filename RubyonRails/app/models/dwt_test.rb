# == Schema Information
#
# Table name: dwt_tests
#
#  id                  :bigint           not null, primary key
#  client_name         :string
#  ear_advantage       :string
#  ear_advantage_score :float
#  interpretation      :string
#  label               :string
#  left_score          :float
#  notes               :text
#  right_score         :float
#  test_type           :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  client_id           :bigint           not null
#  tenant_id           :bigint
#  user_id             :bigint           not null
#
# Indexes
#
#  index_dwt_tests_on_client_id  (client_id)
#  index_dwt_tests_on_tenant_id  (tenant_id)
#  index_dwt_tests_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (client_id => clients.id)
#  fk_rails_...  (tenant_id => tenants.id)
#  fk_rails_...  (user_id => users.id)
#
class DwtTest < ApplicationRecord
    acts_as_tenant(:tenant)
  
    belongs_to :client
    belongs_to :user
end
