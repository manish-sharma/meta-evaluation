class EvaluationSchemeSerializer < ActiveModel::Serializer
  attributes :id, :name, :is_active, :scheme_type,:term_count,:stage_count,:event_marks_decimal_places,:event_scaled_marks_decimal_places,
                  :sub_event_marks_decimal_places,:stage_marks_decimal_places,:absentee_aggregation_rule,:subject_count,:grading_scale_display_name,:grading_scale_id

  has_many :evaluation_terms
  has_many :evaluation_components

  def scheme_type
    object.scheme_type.titlecase
  end

  def absentee_aggregation_rule
    object.absentee_aggregation_rule.titlecase
  end

  def subject_count
    return rand(5)+1
  end

  def grading_scale_display_name
    object.grading_scale.name
  end

  def grading_scale_id
    object.grading_scale_id
  end

end
