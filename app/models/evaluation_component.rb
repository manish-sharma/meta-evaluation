# == Schema Information
#
# Table name: evaluation_components
#
#  id                             :integer          not null, primary key
#  name                           :string
#  component_structure            :integer
#  calculation_method             :integer          default("avg")
#  sequence                       :integer
#  remarks                        :string
#  code                           :string
#  is_active                      :boolean
#  parent_evaluation_component_id :integer
#  evaluation_scheme_id           :integer
#  academic_year_id               :integer
#  deleted_at                     :datetime
#  organization_id                :integer
#  created_by                     :string           not null
#  updated_by                     :string           not null
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#

class EvaluationComponent < ApplicationRecord

  enum component_structure: [:simple, :composite, :multi_occurence]
  enum calculation_method: [:avg, :total, :best_of_all]

  acts_as_tenant(:organization)
  acts_as_paranoid

  belongs_to :parent_evaluation_component, :class_name => 'EvaluationComponent', :foreign_key => 'parent_evaluation_component_id'
  has_many :sub_components, :class_name => 'EvaluationComponent', :foreign_key => 'parent_evaluation_component_id'


end
