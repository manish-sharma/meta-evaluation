class Api::V1::BaseController < ApplicationController

  include ApiRendering
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ArgumentError, with: :render_error
  rescue_from ActiveRecord::StaleObjectError, with: :render_error
end
