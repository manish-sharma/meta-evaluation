class EvaluationSchemeIndexSerializer < ActiveModel::Serializer
  attributes :id, :name, :scheme_type,:term_count,:stage_count, :is_active,:subject_count,:grading_scale_display_name

# TODO: To be changed when scheme is applied
  def subject_count
    return rand(5)+1
  end

  def scheme_type
    object.scheme_type.titlecase
  end

  def grading_scale_display_name
    object.grading_scale.name
  end


end
