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
  validates :name, presence: true, uniqueness: {scope: [:organization_id,:academic_year_id,:deleted_at]}
  validates_presence_of :type, :calculation_method, :sequence, :evaluation_scheme_id, :academic_year_id
  validates_inclusion_of :is_active, in: [true, false]

  #custom validation
  validate :forbid_update_type, on: :update

  scope :sequence_sorted, -> { order(:sequence)}

 scope :parent_evaluation_components, ->{ where(parent_evaluation_component_id: nil)}

  def forbid_update_type
    errors.add(:type, 'can not be updated') if type_changed?
  end

  has_many :evaluation_component_term_stage_details, dependent: :destroy
  belongs_to :evaluation_scheme

  def self.create_evaluation_component_with_marks(klass , params, evaluation_component_term_stage_detail_params)
    ActiveRecord::Base.transaction do
      @evaluation_component = klass.new(params)
      @evaluation_component.bulk_create_details(evaluation_component_term_stage_detail_params) if @evaluation_component.save
      @evaluation_component
    end
  end

  def bulk_create_details(params)
    params[:evaluation_component_term_stage_details].each do |detail|
      detail[:created_by] = self.created_by
      detail[:updated_by] = self.updated_by
        evaluation_component_term_stage_details = self.evaluation_component_term_stage_details.find_or_initialize_by(detail)
        evaluation_component_term_stage_details.save!
    end
  end

  def self.update_evaluation_component_with_marks(id,evaluation_component_params,evaluation_component_term_stage_detail_params)
    ActiveRecord::Base.transaction do
      klass = evaluation_component_params['type'].constantize
      @evaluation_component = klass.find(id)
      @evaluation_component.update_attributes(evaluation_component_params)
      @evaluation_component.bulk_create_update_details(evaluation_component_term_stage_detail_params) if @evaluation_component.valid? && @evaluation_component.type!="CompositeEvaluationComponent"
      @evaluation_component
    end
  end

  def bulk_update_details(params)
    params[:evaluation_component_term_stage_details].each do |detail|
      detail[:updated_by] = self.updated_by
        evaluation_component_term_stage_details = self.evaluation_component_term_stage_details.find_or_initialize_by(detail)
        evaluation_component_term_stage_details.save!
    end
  end


end
