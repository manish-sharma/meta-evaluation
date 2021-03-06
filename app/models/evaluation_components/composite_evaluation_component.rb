class CompositeEvaluationComponent < EvaluationComponent


  #custom validation
  validate :forbid_add_of_child_as_composite, on: :create

  #association
  has_many :sub_components, :class_name => 'EvaluationComponent', :foreign_key => 'parent_evaluation_component_id'

  #callbacks
  before_save :set_default_calculation_method

  def forbid_add_of_child_as_composite
    errors.add(:parent_evaluation_component_id, 'can not be there as sub component can not be of type composite') if parent_evaluation_component_id.present?
  end

  def set_default_calculation_method
    self.calculation_method ||= 'total'
  end

end
