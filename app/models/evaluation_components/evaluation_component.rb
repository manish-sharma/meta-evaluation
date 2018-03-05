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

  #enums
  enum calculation_method: [:avg, :total, :best_of_all]

  acts_as_tenant(:organization)
  acts_as_paranoid


  #validation
  validates :name, presence: true, uniqueness: true
  validates_presence_of :type, :calculation_method, :sequence, :is_active, :evaluation_scheme_id, :academic_year_id

  #custom validation
  validate :forbid_update_type, on: :update


  def forbid_update_type
    errors.add(:type, 'can not be updated') if type_changed?
  end
end
