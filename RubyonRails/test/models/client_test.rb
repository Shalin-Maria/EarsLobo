# == Schema Information
#
# Table name: clients
#
#  id                         :bigint           not null, primary key
#  city                       :string
#  country                    :string
#  encrypted_address1         :string
#  encrypted_address1_iv      :string
#  encrypted_date_of_birth    :date
#  encrypted_date_of_birth_iv :string
#  encrypted_dob_string       :string
#  encrypted_dob_string_iv    :string
#  encrypted_email            :string
#  encrypted_email_iv         :string
#  encrypted_first_name       :string
#  encrypted_first_name_iv    :string
#  encrypted_gender           :string
#  encrypted_gender_iv        :string
#  encrypted_last_name        :string
#  encrypted_last_name_iv     :string
#  encrypted_phone1           :string
#  encrypted_phone1_iv        :string
#  encrypted_phone2           :string
#  encrypted_phone2_iv        :string
#  encrypted_race             :string
#  encrypted_race_iv          :string
#  encrypted_zip              :string
#  encrypted_zip_iv           :string
#  mgmt_ref                   :string
#  right_ear_decibel          :integer
#  state                      :string
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  tenant_id                  :bigint
#
# Indexes
#
#  index_clients_on_tenant_id  (tenant_id)
#
# Foreign Keys
#
#  fk_rails_...  (tenant_id => tenants.id)
#
require "test_helper"

class ClientTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
