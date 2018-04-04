class SimpleEvaluationComponent < EvaluationComponent

before_save :set_default_calculation_method

#custom_validation
validate :forbid_add_as_parent_component, on: :create

belongs_to :parent_evaluation_component,:class_name => 'EvaluationComponent', :foreign_key => 'parent_evaluation_component_id', optional: true

  def set_default_calculation_method
    self.calculation_method ||= 'avg'
  end

  def forbid_add_as_parent_component
    if parent_evaluation_component_id.present?
      klass = EvaluationComponent.find(parent_evaluation_component_id).class.name
      errors.add(:parent_evaluation_component_id,'can not be of type simple/multi occurence type') if klass=="SimpleEvaluationComponent" || klass== "MultiOccurenceEvaluationComponent"
    end
  end

end
