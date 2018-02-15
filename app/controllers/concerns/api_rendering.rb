module ApiRendering extend ActiveSupport::Concern

  def render_404(exception)
    render json: {
        message: exception.message
    }, status: '404'
  end

  def render_error(errors)
    render json: {
        message: errors
    }, status: :unprocessable_entity
  end

  def render_ok
    render json: true
  end

  def render_data(data)
    render status: :ok, json: {
        message: 'success',
        data: data
    }
  end

  def render_success
    render status: :ok, json: {
        message: 'success'
    }
  end

  def render_collection(collection, options = {}, serialize_options = {})
    data = {}
    data[options[:name]] = ActiveModelSerializers::SerializableResource.new(collection, serialize_options)
    if options[:pagination]
      data.merge!(pagination_info(collection))
    end
    render status: :ok, json: {
        message: 'success',
        data: data
    }
  end

  def render_object(object, options = {}, serialize_options = {})
    data = {}
    data[options[:name]] = ActiveModelSerializers::SerializableResource.new(object, serialize_options)
    render status: :ok, json: {
        message: 'success',
        data: data
    }
  end

  def pagination_info(collection)
    {
        total_pages: collection.total_pages,
        current_page: collection.current_page,
        per_page: collection.limit_value,
        total_entries: collection.total_count
    }
  end

  def serializer_options
    options_hash = {}
    options_hash[:bucket_list] = current_user.bucket_list_tasks
    options_hash[:bs_list] = current_user.bs_comments
    options_hash[:approval_list] = current_user.approvals
    options_hash[:current_user] = current_user
    options_hash
  end
end
