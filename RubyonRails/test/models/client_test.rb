# == Schema Information
#
# Table name: clients
#
#  id                           :bigint           not null, primary key
#  address1                     :string
#  city                         :string
#  country                      :string
#  date_of_birth                :date
#  email                        :string
#  emergency_contact_address1   :string
#  emergency_contact_city       :string
#  emergency_contact_first_name :string
#  emergency_contact_last_name  :string
#  emergency_contact_phone1     :string
#  emergency_contact_phone2     :string
#  first_name                   :string
#  gender                       :string
#  last_name                    :string
#  mgmt_ref                     :string
#  phone1                       :string
#  phone2                       :string
#  state                        :string
#  zip                          :string
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#
require "test_helper"

class ClientTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
