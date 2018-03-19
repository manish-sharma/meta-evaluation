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
  validates :name, presence: true, uniqueness: true
  validates :grade_scale_steps, presence: true, :numericality => {:greater_than => 0}

  # custom validations
  validate :forbid_update_grade_scale_step, on: :update

  def bulk_create(user)
    byebug
    grade_scale_steps.times do |i|
      grading_scale_step = self.grading_scale_steps.new( { step_display: "Grading Scale Step #{i+1}", created_by: user, updated_by: user, grading_scale_id: self.id} )
      grading_scale_step.save!(validate: false)
    end
  end

  def forbid_update_grade_scale_step
    errors.add(:grade_scale_steps, 'can not be changed!') if grade_scale_steps_changed?
  end


  def self.create_grading_scales_with_steps(grading_scale_params)
    ActiveRecord::Base.transaction do
      @grading_scale = GradingScale.create(grading_scale_params)
      @grading_scale.bulk_create(grading_scale_params[:created_by]) unless @grading_scale.errors.present?
      @grading_scale
    end
  end

end
