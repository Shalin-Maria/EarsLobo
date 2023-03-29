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
#
class Clinician < ApplicationRecord
end
