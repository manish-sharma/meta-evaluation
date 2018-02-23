class GradingScaleStepSerializer < ActiveModel::Serializer
  attributes :id, :maximum, :minimum, :numeric_display, :step_display, :step_weight
end
