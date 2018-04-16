require 'access_key'
class ApplicationController < ActionController::API
  rescue_from CustomExceptions::NoCurrentUser, with: :handle_no_current_user_error
  set_current_tenant_through_filter

  before_action :current_organization
  before_action :current_user

  def current_organization
    # Don't remove below lines
    # organization = Organization.find(AccessKey.get_data(params[:evaluation_access_key])[:id])
    # organization = Organization.find(AccessKey.get_data(request.headers['HTTP_ACCESS_KEY'])[:id])

    #to be removed after integration with GAE
    # access_key = request.headers['HTTP_ACCESS_KEY'] ||  ENV["ORG1_ACCESS_KEY"]
    access_key = request.headers['HTTP_ACCESS_KEY'] || ((!Rails.env.production?) ? ENV["ORG1_ACCESS_KEY"] : nil)
    organization = Organization.find_by_id(::AccessKey.get_data(access_key)[:id])
    set_current_tenant(organization)
  end

  # Description of method
  #
  # @return [Type] description of returned object
  # @author Shobhit Dixit
  def current_user
    user = params[:current_user] || ( (!Rails.env.production?) ? "dummy_user" : nil)
    User.set_current_user user
  end

  # Description of method
  #
  # @return [Type] description of returned object
  # @author Shobhit Dixit
  def handle_no_current_user_error
    # Not a part of the HTTP standard, 419 Authentication Timeout denotes that previously valid authentication has expired
    # we are using 419 status code, in order to differentiate this error with other errors on client server (GAE)
    render json: { errors: ['No current user is present in the argument.'] }, status: 419
  end

end
