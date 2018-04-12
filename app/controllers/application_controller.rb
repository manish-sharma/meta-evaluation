require 'access_key'
class ApplicationController < ActionController::API
  set_current_tenant_through_filter

  before_action :current_organization
  before_action :current_user

  def current_organization
    # Don't remove below lines
    # organization = Organization.find(AccessKey.get_data(params[:evaluation_access_key])[:id])
    # organization = Organization.find(AccessKey.get_data(request.headers['HTTP_ACCESS_KEY'])[:id])

    #to be removed after integration with GAE
    access_key = request.headers['HTTP_ACCESS_KEY'] ||  ENV["ORG1_ACCESS_KEY"]
    organization = Organization.find(::AccessKey.get_data(access_key)[:id])
    set_current_tenant(organization)
  end

  def current_user
    User.set_current_user( params[:current_user] || "DivyanshuD")
  end

end
