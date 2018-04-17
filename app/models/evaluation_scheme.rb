# == Schema Information
#
# Table name: evaluation_schemes
#
#  id                                :integer          not null, primary key
#  name                              :string           not null
#  scheme_type                       :integer
#  is_active                         :boolean          default(FALSE)
#  term_count                        :integer
#  stage_count                       :integer
#  event_marks_decimal_places        :integer          default(2)
#  event_scaled_marks_decimal_places :integer          default(2)
#  stage_marks_decimal_places        :integer          default(2)
#  sub_event_marks_decimal_places    :integer          default(2)
#  absentee_aggregation_rule         :integer
#  is_practical                      :boolean          default(FALSE)
#  lock_version                      :integer
#  department_id                     :integer
#  deleted_at                        :datetime
#  grading_scale_id                  :integer
#  organization_id                   :integer
#  created_by                        :string           not null
#  updated_by                        :string           not null
#  created_at                        :datetime         not null
#  updated_at                        :datetime         not null
#

class EvaluationScheme < ApplicationRecord
  include Filterable

  acts_as_tenant(:organization)
  acts_as_paranoid

  #enums
  enum scheme_type: {"grading" => 0 , "numeric"=>1}
  enum absentee_aggregation_rule: {"assign_zero_marks"=>0, "assign_pro_data_marks"=>1, "ignore_event"=>2}

  #valiations
  validates :name, presence: true, uniqueness: {scope: [:name,:organization_id,:deleted_at]}
  validates :grading_scale_id, presence: true
  validates :scheme_type, presence: true
  validates :term_count, :stage_count, presence: true, :numericality => {:greater_than => 0}

  # custom validations
  validate :forbid_update_term_and_stage, on: :update
  validate :forbid_update_scheme_type, on: :update

  #association
  has_many :evaluation_terms, dependent: :destroy
  has_many :evaluation_components , dependent: :destroy
  belongs_to :grading_scale

  def forbid_update_term_and_stage
    errors.add(:term_count, 'can not be changed!') if term_count_changed?
    errors.add(:stage_count, 'can not be changed!') if stage_count_changed?
  end

  def forbid_update_scheme_type
    errors.add(:scheme_type, 'can not be changed!') if scheme_type_changed?
  end

  def self.by_is_active(value = true)
    where(is_active: value)
  end

  def bulk_create_terms_and_stages
    (1..term_count).each do |term|
      term_params = { sequence: term, name: "Term #{term}", created_by: self.created_by, updated_by: self.updated_by, evaluation_scheme_id: id }
      evaluation_term = evaluation_terms.create!(term_params)
      (1..stage_count).each do |stage|
        stage_params = { sequence: stage, name: "Stage #{stage}", created_by: self.created_by, updated_by: self.updated_by, evaluation_term_id: evaluation_term.id}
        evaluation_stage = evaluation_term.evaluation_stages.create!(stage_params)
      end
    end
  end

  def self.create_evaluation_scheme_with_terms_and_stages(evaluation_scheme_params)
    ActiveRecord::Base.transaction do
      evaluation_scheme = EvaluationScheme.new(evaluation_scheme_params.merge({created_by: User.current_user,updated_by: User.current_user}))
      evaluation_scheme.bulk_create_terms_and_stages if evaluation_scheme.save
      evaluation_scheme
    end
  end

end
