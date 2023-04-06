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
  has_many :emergency_contacts, dependent: :destroy
  accepts_nested_attributes_for :emergency_contacts
  validates :address1, :city, :country, :date_of_birth, :email, :first_name, :gender, :last_name, :mgmt_ref, :phone1, :state, :zip, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone1, :phone2, format: { with: /\A\d{10}\z/, message: "must be a 10-digit phone number" }, allow_blank: true
end


