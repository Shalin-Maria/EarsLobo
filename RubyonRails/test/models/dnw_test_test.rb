# == Schema Information
#
# Table name: dnw_tests
#
#  id                  :bigint           not null, primary key
#  client_name         :string
#  ear_advantage       :string
#  ear_advantage_score :float
#  label               :string
#  left_score          :float
#  notes               :text
#  right_score         :float
#  test_type           :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  client_id           :bigint           not null
#  tenant_id           :bigint
#
# Indexes
#
#  index_dnw_tests_on_client_id  (client_id)
#  index_dnw_tests_on_tenant_id  (tenant_id)
#
# Foreign Keys
#
#  fk_rails_...  (client_id => clients.id)
#  fk_rails_...  (tenant_id => tenants.id)
#
require "test_helper"

class DnwTestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
