class EvaluationSchemeSerializer < ActiveModel::Serializer
  attributes :id, :name, :is_active, :scheme_type,:term_count,:stage_count,:event_marks_decimal_places,:event_scaled_marks_decimal_places,
                  :sub_event_marks_decimal_places,:stage_marks_decimal_places,:absentee_aggregation_rule

  has_many :evaluation_terms
  belongs_to :grading_scale
  #has_many :evaluation_components
end
