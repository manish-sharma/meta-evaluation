class GradingScale < ApplicationRecord
  acts_as_tenant(:organization)
end
