class EvaluationSchemeResource < ApplicationRecord
  acts_as_tenant(:organization)
  acts_as_paranoid

  validates :resource_type, :resource_id, :academic_year_unit_id, presence: true
  validates :resource_id, uniqueness: {scope: [:resource_type,:academic_year_unit_id,:organization_id,:deleted_at]}

  has_one :resource_evaluation_scheme

end
