class Api::V1::BaseController < ApplicationController

  include Respondable
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ArgumentError, with: :render_error
  rescue_from ActiveRecord::StaleObjectError, with: :handle_conflict_error

  def handle_record_not_found_error
    render_error(['No such record found.'])
  end

  def handle_conflict_error
    render_error(['This record is updated by someone else. Please refresh and try again.'])
  end


end
