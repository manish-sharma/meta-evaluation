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
#  event_marks_decimal_places        :integer
#  event_scaled_marks_decimal_places :integer
#  stage_marks_decimal_places        :integer
#  sub_event_marks_decimal_places    :integer
#  absentee_aggregation_rule         :integer
#  is_practical                      :boolean
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
  acts_as_tenant(:organization)
  acts_as_paranoid
end
