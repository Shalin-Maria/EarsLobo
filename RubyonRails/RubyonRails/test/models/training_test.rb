# == Schema Information
#
# Table name: trainings
#
#  id                   :bigint           not null, primary key
#  client_name          :string
#  ear_advanatage_score :string
#  ear_advantage        :string
#  left_score           :string
#  right_score          :string
#  week                 :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  client_id            :bigint
#
# Indexes
#
#  index_trainings_on_client_id  (client_id)
#
# Foreign Keys
#
#  fk_rails_...  (client_id => clients.id)
#
require "test_helper"

class TrainingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
