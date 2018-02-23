class EvaluationTermSerializer < ActiveModel::Serializer
  attributes :id,:name,:sequence,:is_active,:academic_year_id,:organization_id

  has_many :evaluation_stages
end
