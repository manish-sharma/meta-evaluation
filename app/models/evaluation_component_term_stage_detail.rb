# == Schema Information
#
# Table name: evaluation_component_term_stage_details
#
#  id                      :integer          not null, primary key
#  evaluation_stage_id     :integer
#  max_marks               :decimal(, )
#  evaluation_component_id :integer
#  lock_version            :integer
#  deleted_at              :datetime
#  organization_id         :integer
#  created_by              :string           not null
#  updated_by              :string           not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

class EvaluationComponentTermStageDetail < ApplicationRecord

  acts_as_tenant(:organization)
  acts_as_paranoid

  belongs_to :evaluation_component
  belongs_to :evaluation_stage
end
