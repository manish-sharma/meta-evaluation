class EvaluationComponentTermStageDetail < ApplicationRecord

  acts_as_tenant(:organization)
  acts_as_paranoid

  belongs_to :evaluation_component
  belongs_to :evaluation_stage
end
