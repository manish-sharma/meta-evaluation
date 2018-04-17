class EvaluationTermSerializer < ActiveModel::Serializer
  attributes :id,:name,:sequence,:is_active

  has_many :evaluation_stages
end
