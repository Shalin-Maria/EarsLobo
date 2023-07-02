# == Schema Information
#
# Table name: tenants
#
#  id         :bigint           not null, primary key
#  subdomain  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Tenant < ApplicationRecord
    validates :subdomain, uniqueness: true
    validates :subdomain, presence: true, uniqueness: true, 
            format: { with: /\A[\w+\-.]+\z/, message: "only allows letters, numbers, hyphens, underscores, and periods." }

end
