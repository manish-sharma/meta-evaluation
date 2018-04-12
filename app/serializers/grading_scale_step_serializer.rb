class GradingScaleStepSerializer < ActiveModel::Serializer
  attributes :id, :maximum, :minimum, :numeric_display, :step_display_name, :step_weight, :color, :result,:lock_version
end
