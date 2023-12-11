# == Schema Information
#
# Table name: week_fours
#
#  id                  :bigint           not null, primary key
#  client_name         :string
#  counter             :integer
#  ear_advantage       :string
#  ear_advantage_score :float
#  left_ear_decibel    :integer
#  left_score          :float
#  notes               :text
#  right_ear_decibel   :integer
#  right_score         :float
#  test_type           :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  client_id           :bigint           not null
#  tenant_id           :bigint           not null
#  user_id             :bigint           not null
#
# Indexes
#
#  index_week_fours_on_client_id  (client_id)
#  index_week_fours_on_tenant_id  (tenant_id)
#  index_week_fours_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (client_id => clients.id)
#  fk_rails_...  (tenant_id => tenants.id)
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class WeekFourTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
