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
class Client < ApplicationRecord
    has_many :emergency_contacts,dependent: :destroy
    validates :first_name, :last_name, :email, :date_of_birth, :address1, :country, :state, :city, :zip, :phone1, presence: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :phone1, numericality: { only_integer: true }
  


    attribute :mgmt_ref, :string
    attribute :phone2, :string
    attribute :emergency_contact_first_name, :string
    attribute :emergency_contact_last_name, :string
    attribute :emergency_contact_phone1, :string
    attribute :emergency_contact_phone2, :string
    attribute :emergency_contact_address1, :string
    attribute :emergency_contact_city, :string
  
  end

