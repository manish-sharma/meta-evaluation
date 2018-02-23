# == Schema Information
#
# Table name: evaluation_terms
#
#  id                   :integer          not null, primary key
#  name                 :string
#  sequence             :integer
#  is_active            :boolean          default(FALSE)
#  evaluation_scheme_id :integer
#  academic_year_id     :integer
#  deleted_at           :datetime
#  organization_id      :integer
#  created_by           :string           not null
#  updated_by           :string           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class EvaluationTerm < ApplicationRecord
  acts_as_tenant(:organization)
  acts_as_paranoid
  has_many :evaluation_stages, dependent: :destroy
end
