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
