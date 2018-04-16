class Api::V1::EvaluationSchemeResourcesController < Api::V1::BaseController

  # Show list of evaluation_scheme_resource
  #
  # @return [Array] list of evaluation_scheme_resource
  # @author Shobhit Dixit
  # def index
  #   @evaluation_scheme_resources = EvaluationSchemeResource.page(params[:page])
  #    render_collection(@evaluation_scheme_resources, { name: 'evaluation_scheme_resources' ,pagination: pagination_info(@evaluation_scheme_resources) }, {each_serializer: EvaluationSchemeResourceIndexSerializer})
  # end

  # Create call for evaluation_scheme_resource
  # @return [Object]
  # @author Shobhit Dixit
  def create
    @evaluation_scheme_resource = EvaluationSchemeResource.new(evaluation_scheme_resource_params.merge({created_by: User.current_user, updated_by: User.current_user}))
    render_object(@evaluation_scheme_resource, { name: 'evaluation_scheme_resource' }, {}) and return if @evaluation_scheme_resource.save
    render_error(@evaluation_scheme_resource.errors.full_messages)
  end

  # Show call for evaluation_scheme_resource
  # @return [Object]
  # @author Shobhit Dixit
  def show
    @evaluation_scheme_resource = EvaluationSchemeResource.find_by_id params[:id]
    render_object(@evaluation_scheme_resource, { name: 'evaluation_scheme_resource' }, {})
  end

end
