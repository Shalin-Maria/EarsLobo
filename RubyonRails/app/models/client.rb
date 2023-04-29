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
#  state         :string
#  zip           :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Client < ApplicationRecord
    has_many :emergency_contacts,dependent: :destroy
    has_many :tests

    accepts_nested_attributes_for :emergency_contacts
    validates :first_name, :last_name, :email, :date_of_birth, :address1, :country, :state, :city, :zip, :phone1, presence: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :phone1, numericality: { only_integer: true }

    def full_name
      "#{first_name} #{last_name}"
    end
end
  


