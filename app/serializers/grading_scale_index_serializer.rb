class GradingScaleIndexSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :grade_scale_steps, :is_for_result,:lock_version
end
