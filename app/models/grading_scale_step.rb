# == Schema Information
#
# Table name: grading_scale_steps
#
#  id               :integer          not null, primary key
#  maximum          :decimal(, )
#  minimum          :decimal(, )
#  numeric_display  :integer
#  step_display     :string
#  step_weight      :integer
#  deleted_at       :datetime
#  organization_id  :integer
#  grading_scale_id :integer
#  created_by       :string           not null
#  updated_by       :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class GradingScaleStep < ApplicationRecord
  acts_as_tenant(:organization)
  acts_as_paranoid

  #associations
  belongs_to :grading_scale

  #callbacks
  after_create :update_grade_scale_step
  after_destroy :update_grade_scale_step
  after_restore :update_grade_scale_step

  #validations
  validates :step_display, presence: true, uniqueness: {scope:  [:grading_scale,:organization_id]}
  validates :numeric_display, presence: true, uniqueness: {scope:  [:grading_scale,:organization_id]}
  validates :step_weight, presence: true, uniqueness: {scope:  [:grading_scale,:organization_id]}
  validates :maximum, presence: true, uniqueness: {scope:  [:grading_scale,:organization_id]}
  validates :minimum, presence: true, uniqueness: {scope:  [:grading_scale,:organization_id]}

  def update_grade_scale_step
    @grading_scale = grading_scale
    @grading_scale.grade_scale_steps = @grading_scale.grading_scale_steps.size
    @grading_scale.save(validate: false)
  end
end
