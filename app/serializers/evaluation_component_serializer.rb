class EvaluationComponentSerializer < ActiveModel::Serializer
  attributes :id, :name, :type, :is_active, :calculation_method, :sequence
end
