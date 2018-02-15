# == Schema Information
#
# Table name: evaluation_terms
#
#  id                         :integer          not null, primary key
#  name                       :string
#  from_date                  :datetime
#  to_date                    :datetime
#  working_days               :integer
#  sequence                   :integer
#  is_active                  :boolean          default(FALSE)
#  result_submit_date         :datetime
#  result_publish_date        :datetime
#  evaluation_scheme_id       :integer
#  academic_year_structure_id :integer
#  deleted_at                 :datetime
#  organization_id            :integer
#  created_by                 :string           not null
#  updated_by                 :string           not null
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#

class EvaluationTerm < ApplicationRecord
  acts_as_tenant(:organization)
  acts_as_paranoid
end
