# == Schema Information
#
# Table name: grading_scale_steps
#
#  id                :integer          not null, primary key
#  maximum           :decimal(, )
#  minimum           :decimal(, )
#  numeric_display   :integer
#  step_display_name :string
#  color             :integer
#  result            :integer
#  step_weight       :integer
#  deleted_at        :datetime
#  lock_version      :integer
#  organization_id   :integer
#  grading_scale_id  :integer
#  created_by        :string           not null
#  updated_by        :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class GradingScaleStep < ApplicationRecord
  # acts_as_tenant(:organization)
  acts_as_paranoid

  default_scope { order(step_weight: :desc) }

  #enums
  enum result: {"Advised To Repeat" => 0,"Assignment"=> 1, "Compartment"=>2,"Eligible For Improvement In Performance"=>3,"Promoted"=>4,"Qualified"=>5}
  enum color: {"Green" => 0,"Red" => 1 ,"Yellow" => 2}

  #associations
  belongs_to :grading_scale

  #callbacks
  after_create :update_grade_scale_step
  after_destroy :update_grade_scale_step
  after_restore :update_grade_scale_step

  #validations
  validates :step_display_name, presence: true, uniqueness: {scope:  [:grading_scale,:organization_id]}
  validates :numeric_display, presence: true, uniqueness: {scope:  [:grading_scale,:organization_id]}
  validates :step_weight, presence: true, uniqueness: {scope:  [:grading_scale,:organization_id]}
  validates :maximum, presence: true, uniqueness: {scope:  [:grading_scale,:organization_id]}
  validates :minimum, presence: true, uniqueness: {scope:  [:grading_scale,:organization_id]}
  validates :result , presence: true, if: :check_for_result


  def update_grade_scale_step
    @grading_scale = grading_scale
    @grading_scale.grade_scale_steps = @grading_scale.grading_scale_steps.size
    @grading_scale.save(validate: false)
  end

  def check_for_result
    self.grading_scale.is_for_result
  end
end
