class EvaluationSchemeResourceSerializer < ActiveModel::Serializer
  attributes :id, :resource_type, :resource_id, :academic_year_unit_id, :lock_version
end
