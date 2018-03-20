# == Schema Information
#
# Table name: grading_scales
#
#  id                :integer          not null, primary key
#  name              :string
#  description       :text
#  grade_scale_steps :integer
#  is_for_result     :boolean          default(FALSE)
#  deleted_at        :datetime
#  organization_id   :integer
#  created_by        :string           not null
#  updated_by        :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class GradingScale < ApplicationRecord
   acts_as_tenant(:organization)
   acts_as_paranoid

  #associations
  has_many :grading_scale_steps, dependent: :destroy
  has_many :evaluation_schemes

  #validation
  validates :name, presence: true
  validates :grade_scale_steps, presence: true, :numericality => {:greater_than => 0}
  validates :name, uniqueness: {scope: [:organization_id,:deleted_at]}

  # custom validations
  validate :forbid_update_grade_scale_step, on: :update

  def bulk_create(user)
    (1..grade_scale_steps).each do |i|
      step_display = "Grading Scale Step #{i}"
      grading_scale_step = GradingScaleStep.new( { step_display: step_display, created_by: user, updated_by: user, grading_scale_id: id} )
      grading_scale_step.save!(validate: false)
    end
  end

  def forbid_update_grade_scale_step
    errors.add(:grade_scale_steps, 'can not be changed!') if grade_scale_steps_changed?
  end


  def self.create_grading_scales_with_steps(grading_scale_params)
     ActiveRecord::Base.transaction do
      @grading_scale = GradingScale.new(grading_scale_params)
      @grading_scale.bulk_create(grading_scale_params[:created_by]) if @grading_scale.save
      @grading_scale
    end
  end

end
