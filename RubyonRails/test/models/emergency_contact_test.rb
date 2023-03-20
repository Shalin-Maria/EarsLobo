# == Schema Information
#
# Table name: emergency_contacts
#
#  id           :bigint           not null, primary key
#  address      :string
#  city         :string
#  email        :string
#  first_name   :string
#  last_name    :string
#  phone_number :string
#  state        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_emergency_contacts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class EmergencyContactTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
