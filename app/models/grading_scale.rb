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
  has_many :grading_scale_steps, dependent: :destroy
  validates :name, presence: true, uniqueness: true
  validates :grade_scale_steps, presence: true
  # custom validations
  validate :forbid_update_grade_scale_step, on: :update

  def bulk_create
    for i in 1..grade_scale_steps
      step_display = "Grading Scale Step #{i}"
      grading_scale_steps.create( { step_display: step_display} )
    end
  end

  def forbid_update_grade_scale_step
    errors.add(:grade_scale_steps, 'can not be changed!') if grade_scale_steps_changed?
  end

end
