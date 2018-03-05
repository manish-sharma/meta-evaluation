class EvaluationComponentSerializer < ActiveModel::Serializer
  attributes :id, :name, :type, :active, :calculation_method, :sequence
end
