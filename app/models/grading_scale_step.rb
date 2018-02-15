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
  belongs_to :gradin_scale
  after_create :update_grade_scale_step
  after_destroy :update_grade_scale_step

  def update_grade_scale_step
    @gradin_scale = self.grading_scale
    @grading_scale.grade_scale_step = @grading_scale.gradin_scale_steps.size
    @grading_scale.save(validates: false)
  end
end
