class MultiOccurenceEvaluationComponent < EvaluationComponent

  # custom_validation
  validate :forbid_adding_child_component, on: :create

  def forbid_adding_child_component
    byebug
    errors.add(:parent_evaluation_component_id, 'is not allowed as child component') if parent_evaluation_component_id.present?
  end

end
