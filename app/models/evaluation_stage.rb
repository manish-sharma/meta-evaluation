# == Schema Information
#
# Table name: evaluation_stages
#
#  id                 :integer          not null, primary key
#  name               :string
#  sequence           :integer
#  evaluation_term_id :integer
#  deleted_at         :datetime
#  academic_year_id   :integer
#  organization_id    :integer
#  created_by         :string           not null
#  updated_by         :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class EvaluationStage < ApplicationRecord
  acts_as_tenant(:organization)
  acts_as_paranoid
end
