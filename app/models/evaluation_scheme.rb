# == Schema Information
#
# Table name: evaluation_schemes
#
#  id                                :integer          not null, primary key
#  name                              :string           not null
#  type                              :integer
#  is_active                         :boolean          default(FALSE)
#  term_count                        :integer
#  stage_count                       :integer
#  event_marks_decimal_places        :integer          default(2)
#  event_scaled_marks_decimal_places :integer          default(2)
#  stage_marks_decimal_places        :integer          default(2)
#  sub_event_marks_decimal_places    :integer          default(2)
#  absentee_aggregation_rule         :integer
#  is_practical                      :boolean          default(FALSE)
#  department_id                     :integer
#  academic_year_id                  :integer
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
  enum scheme_type: [:grading, :numeric]
  enum absentee_aggregation_rule: [:assign_zero_marks, :assign_pro_data_marks, :ignore_event]

  #valiations
  validates :name, presence: true, uniqueness: {scope: [:name,:academic_year_id,:organization_id,:deleted_at]}
  validates :grading_scale_id, presence: true
  validates :scheme_type, presence: true
  validates :academic_year_id, presence: true
  validates :term_count, :stage_count, presence: true, :numericality => {:greater_than => 0}

  # custom validations
  validate :forbid_update_term_and_stage, on: :update
  validate :forbid_update_scheme_type, on: :update

  #association
  has_many :evaluation_terms, dependent: :destroy
  #has_many :evaluation_components , dependent: :destroy
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

  def bulk_create_terms_and_stages(academic_year_id, user_id)
    (1..term_count).each do |term|
      term_params = { sequence: term, name: "Term #{term}", created_by: user_id, updated_by: user_id, evaluation_scheme_id: id, academic_year_id: academic_year_id }
      evaluation_term = evaluation_terms.create!(term_params)
      (1..stage_count).each do |stage|
        stage_params = { sequence: stage, name: "Stage #{stage}", created_by: user_id, updated_by: user_id, evaluation_term_id: evaluation_term.id, academic_year_id: academic_year_id }
        evaluation_stage = evaluation_term.evaluation_stages.create!(stage_params)
      end
    end
  end

  def self.create_evaluation_scheme_with_terms_and_stages(evaluation_scheme_params)
    ActiveRecord::Base.transaction do
      evaluation_scheme = EvaluationScheme.new(evaluation_scheme_params)
      evaluation_scheme.bulk_create_terms_and_stages(evaluation_scheme_params[:academic_year_id], evaluation_scheme_params[:created_by]) if evaluation_scheme.save
      evaluation_scheme
    end
  end

end
