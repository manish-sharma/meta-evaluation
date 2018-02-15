class ApplicationController < ActionController::API
  include ApiRendering
  set_current_tenant_through_filter

  before_action :current_organization

  def current_organization
    organization = Organization.find(AccessKey.get_data(params[:access_key])[:id])
    set_current_tenant(organization)
  end

end
