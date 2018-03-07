class ApplicationController < ActionController::API
  set_current_tenant_through_filter

  before_action :current_organization
  before_action :current_user

  def current_organization
    organization = Organization.find(AccessKey.get_data(params[:access_key])[:id])
    set_current_tenant(organization)
  end

  # TODO: To be used in future if required. For now it's of no use
  def current_user
    current_user = "12346578"
  end


end
