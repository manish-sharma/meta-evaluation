class ResourceEvaluationScheme < ApplicationRecord
  acts_as_tenant(:organization)
  acts_as_paranoid

  validates :evaluation_scheme_resource_id, :evaluation_scheme_id, presence: true
  validates :evaluation_scheme_resource_id, uniqueness: {scope: [:evaluation_scheme_id, :organization_id,:deleted_at]}

  belongs_to :evaluation_scheme_resource
end
