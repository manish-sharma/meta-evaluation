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

class EvaluationComponent < ApplicationRecord

  #enums
  enum calculation_method: {"Average" => 0,"Total" => 1 ,"Best Of All" => 2}
  enum evaluation_group: {"All"=>0, "Oral"=> 1,"Theory"=>4,"Practical"=>2,"Project"=>3}

  acts_as_tenant(:organization)
  acts_as_paranoid


  #validation
  validates :name, presence: true, uniqueness: {scope: [:organization_id,:deleted_at]}
  validates_presence_of :type, :calculation_method, :sequence, :evaluation_scheme_id
  validates_inclusion_of :is_active, in: [true, false]

  #custom validation
  validate :forbid_update_type, on: :update

  #associations
  has_many :evaluation_component_term_stage_details, dependent: :destroy
  belongs_to :evaluation_scheme

  #scopes
  scope :sequence_sorted, -> { order(:sequence)}

  scope :parent_evaluation_components, ->{ where(parent_evaluation_component_id: nil)}

  def forbid_update_type
    errors.add(:type, 'can not be updated') if type_changed?
  end


  def self.create_evaluation_component_with_marks(klass , params)
    params.merge!({created_by: User.current_user,updated_by: User.current_user})
    params[:evaluation_component_term_stage_details_attributes]= params[:evaluation_component_term_stage_details_attributes].map {|r| r.merge({created_by: User.current_user,updated_by: User.current_user}) }
    @evaluation_component = klass.new(params)
    if @evaluation_component.valid?
      ActiveRecord::Base.transaction do
        @evaluation_component.save
      end
    end
    @evaluation_component
  end

  # def bulk_create_details(params)
  #   params[:evaluation_component_term_stage_details].each do |detail|
  #       detail.merge({created_by: User.current_user,updated_by: User.current_user})
  #       evaluation_component_term_stage_details = self.evaluation_component_term_stage_details.find_or_initialize_by(detail)
  #       evaluation_component_term_stage_details.save!
  #   end
  # end


  def self.update_evaluation_component_with_marks(id,evaluation_component_params,evaluation_component_term_stage_detail_params)
    evaluation_component_params.merge!({updated_by: User.current_user})
    evaluation_component_params[:evaluation_component_term_stage_details_attributes] = evaluation_component_params[:evaluation_component_term_stage_details_attributes].map {|r| r.merge({updated_by: User.current_user})}
    klass = evaluation_component_params['type'].constantize
    @evaluation_component = klass.find(id)
    @evaluation_component.update_attributes(evaluation_component_params)
    @evaluation_component
  end

  def bulk_update_details(params)
    params[:evaluation_component_term_stage_details].each do |detail|
        detail.merge({updated_by: User.current_user})
        evaluation_component_term_stage_details = EvaluationComponentTermStageDetail.where(evaluation_component_id: self.id).where(evaluation_stage_id: detail[:evaluation_stage_id]).try(:first)
        if evaluation_component_term_stage_details.present?
          evaluation_component_term_stage_details.max_marks = detail[:max_marks]
          evaluation_component_term_stage_details.save!
      end
    end
  end


end
