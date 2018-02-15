class GradingScaleSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :grade_scale_steps, :is_for_result, :grading_scale_steps

  has_many :grading_scale_steps
end
