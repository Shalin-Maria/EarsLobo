# == Schema Information
#
# Table name: clinicians
#
#  id         :bigint           not null, primary key
#  email      :string
#  fname      :string
#  lname      :string
#  phone      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  tenant_id  :bigint
#
# Indexes
#
#  index_clinicians_on_tenant_id  (tenant_id)
#
# Foreign Keys
#
#  fk_rails_...  (tenant_id => tenants.id)
#
class Clinician < ApplicationRecord
    acts_as_tenant(:tenant)

end
