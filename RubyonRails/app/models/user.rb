# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  fname                  :string
#  lname                  :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  tenant_id              :bigint
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_tenant_id             (tenant_id)
#
# Foreign Keys
#
#  fk_rails_...  (tenant_id => tenants.id)
#
class User < ApplicationRecord
  acts_as_tenant(:tenant)

  belongs_to :tenant
  enum role: { regular_user: 0, local_moderator: 1, global_moderator: 2 }
  attr_accessor :registration_key
  attr_accessor :subdomain
  before_create :validate_registration_key

  has_many :tests
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  private
  def validate_registration_key
    key = Key.find_by(code: registration_key, used: false)
    if key.present?
      key.update(used: true)
      self.tenant = Tenant.create!(subdomain: subdomain)
    else
      errors.add(:registration_key, "is invalid.")
      throw(:abort)
    end
  end
  

  def generate_subdomain
    # You may want to generate a subdomain based on some user's data (for example, email).
    # This is a very basic implementation which takes a part before '@' symbol from the email.
    # Be aware this might not be unique. You will need to add validations or create more sophisticated logic.
    self.email.split('@').first
  end
end

