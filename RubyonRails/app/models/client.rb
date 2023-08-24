# == Schema Information
#
# Table name: clients
#
#  id            :bigint           not null, primary key
#  address1      :string
#  city          :string
#  country       :string
#  date_of_birth :date
#  email         :string
#  first_name    :string
#  gender        :string
#  last_name     :string
#  mgmt_ref      :string
#  phone1        :string
#  phone2        :string
#  race          :string
#  state         :string
#  zip           :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  tenant_id     :bigint
#
# Indexes
#
#  index_clients_on_tenant_id  (tenant_id)
#
# Foreign Keys
#
#  fk_rails_...  (tenant_id => tenants.id)
#
class Client < ApplicationRecord
    acts_as_tenant(:tenant)

    has_many :emergency_contacts,dependent: :destroy
    has_many :dwt_tests,dependent: :destroy
    has_many :dnw_tests,dependent: :destroy
    has_many :rddt_tests,dependent: :destroy


    accepts_nested_attributes_for :emergency_contacts
    validates :first_name, :last_name, :email, :date_of_birth, :address1, :country, :state, :city, :zip, :phone1, presence: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :phone1, numericality: { only_integer: true }

    def full_name
      "#{first_name}#{last_name}"
    end
#age in years method that calculates a clients age based on DOB then passes it to the script test page
    def age_in_years
      now = Time.now.utc.to_date
      dob = date_of_birth
      age = now.year - dob.year
      age -= 1 if now < dob + age.years # for days before birthday
      age
    end


    def anonymized
      self.attributes.except('address1', 'email', 'phone1', 'phone2')
        .merge({
          'address1' => Digest::SHA256.hexdigest(self.address1),
          'email' => Digest::SHA256.hexdigest(self.email),
          'phone1' => Digest::SHA256.hexdigest(self.phone1),
          'phone2' => Digest::SHA256.hexdigest(self.phone2)
        })
    end
end
  


