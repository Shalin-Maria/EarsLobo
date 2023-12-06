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
#  left_ear_decibel           :integer
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
class Client < ApplicationRecord
  acts_as_tenant(:tenant)
  
  attr_encrypted :email, :address1, :date_of_birth, :first_name, :last_name, :phone1, :phone2, :gender, :race, :zip, key: ENV['ENCRYPTION_KEY']
  attr_encrypted :dob_string, key: ENV['ENCRYPTION_KEY']

  
    has_many :emergency_contacts,dependent: :destroy
    has_many :dwt_tests,dependent: :destroy
    has_many :dnw_tests,dependent: :destroy
    has_many :rddt_tests,dependent: :destroy
    has_many(
      :week_ones,
      class_name: 'WeekOne',
      foreign_key: 'client_id',
      inverse_of: :client,
      dependent: :destroy
      )
    has_many(
      :trainings,
      class_name: 'Training',
      foreign_key: 'client_id',
      inverse_of: :client,
     dependent: :destroy
     )
  # Associations with emergency contacts and tests, with dependent destroy option


  # Allow nested attributes for emergency contacts
  accepts_nested_attributes_for :emergency_contacts


  
    def date_of_birth=(date)
      self.dob_string = date.to_s
    end
    # The setter for the raw_date_of_birth, used internally
   

    def date_of_birth
      return if dob_string.nil?
      Date.parse(dob_string)
    end
    
  

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
  # Validations for various client attributes
  validates :first_name, :last_name, :email, :address1, :country, :state, :city, :zip, :phone1, :date_of_birth, presence: true

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone1, numericality: { only_integer: true }

  # Allow these attributes to be searched through Ransack
  def self.ransackable_attributes(auth_object = nil)
    %w(id address1 city country date_of_birth email first_name gender last_name mgmt_ref phone1 phone2 race state zip created_at updated_at tenant_id age_in_years age ) + _ransackers.keys
  end

  # Allow these associations to be searched through Ransack
  def self.ransackable_associations(auth_object = nil)
    ["emergency_contacts", "tenant", "tests"]
  end

  # Controls the functionality behind thw advanced searching for this attribute of id
  ransacker :id do
    Arel.sql('id')
  end

end
  


