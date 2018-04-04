class ApplicationController < ActionController::API
  set_current_tenant_through_filter

  before_action :current_organization
  before_action :current_user
  before_action :set_created_by

  def current_organization
   # organization = Organization.find(AccessKey.get_data(params[:evaluation_access_key])[:id])
   # organization = Organization.find(AccessKey.get_data(request.headers['HTTP_ACCESS_KEY'])[:id])
   organization = Organization.find(AccessKey.get_data('eyJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwiZG4iOiJ4YXZpZXJqYWlwdXIub3JnIiwiaWF0IjoiMjAxOC0wNC0wM1QxNDo0MTozOCswNTozMCIsImV4cCI6MTU1NDMwMzY1MH0.FT3WqhgBdK55ChimX_soiO-3o7yQog-PLD_iyzchElU')[:id])
  set_current_tenant(organization)
  end

  # TODO: To be used in future if required. For now it's of no use
  def current_user
    current_user = params[:current_user]
  end

  def set_created_by
    if params.present? && params[:grading_scale].present?
    params[:grading_scale][:created_by]="Divyanshu"
    params[:grading_scale][:updated_by]="Divyanshu"
  end
  if params.present? && params[:grading_scale_step].present?
  params[:grading_scale_step][:created_by]="Divyanshu"
  params[:grading_scale_step][:updated_by]="Divyanshu"
end
if params.present? && params[:evaluation_scheme].present?
params[:evaluation_scheme][:created_by]="Divyanshu"
params[:evaluation_scheme][:updated_by]="Divyanshu"
end
  end


end
