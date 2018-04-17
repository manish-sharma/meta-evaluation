# == Schema Information
#
# Table name: evaluation_components
#
#  id                             :integer          not null, primary key
#  name                           :string
#  type                           :string
#  calculation_method             :integer          default(0)
#  evaluation_group               :integer          default(0)
#  category                       :integer          default(0)
#  report_card_name               :string
#  sequence                       :integer
#  remarks                        :string
#  code                           :string
#  is_active                      :boolean          default(TRUE)
#  lock_version                   :integer
#  parent_evaluation_component_id :integer
#  evaluation_scheme_id           :integer
#  deleted_at                     :datetime
#  organization_id                :integer
#  created_by                     :string           not null
#  updated_by                     :string           not null
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#

class MultiOccurenceEvaluationComponent < EvaluationComponent

  # custom_validation
  validate :forbid_add_as_parent_component, on: :create

  #associations
  belongs_to :parent_evaluation_component,:class_name => 'EvaluationComponent', :foreign_key => 'parent_evaluation_component_id', optional: true
  accepts_nested_attributes_for :evaluation_component_term_stage_details, reject_if: :all_blank

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
