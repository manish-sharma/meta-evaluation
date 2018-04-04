class EvaluationComponentSerializer < ActiveModel::Serializer
  attributes :id, :name, :type, :is_active, :calculation_method, :sequence
  has_many :evaluation_component_term_stage_details, if: :is_not_composite?

  has_many :sub_components, if: :is_composite?


  def is_composite?
    return object.type=="CompositeEvaluationComponent" ? true : false
  end

  def is_not_composite?
    return object.type=="CompositeEvaluationComponent" ? false : true
  end

end
