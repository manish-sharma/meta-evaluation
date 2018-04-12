    class Api::V1::GradingScalesController < Api::V1::BaseController

      # Description of #create
      # @return [GradingScale] grading scale with grading scale steps
      # @author Divyanshu
      def create
        @grading_scale = GradingScale.new(grading_scale_params.merge({created_by: User.current_user, updated_by: User.current_user}))
        render_object(@grading_scale, { name: 'grading_scale' }, {}) and return if @grading_scale.save
        render_error(@grading_scale.errors.full_messages)
      end

      # Description of #index
      # @return [Collection[GradingScale]] collection of grading scale with grading scale steps
      # @author Divyanshu
      def index
        @grading_scales = GradingScale.includes(:grading_scale_steps).page(params[:page])
         render_collection(@grading_scales, { name: 'grading_scales' ,pagination: pagination_info(@grading_scales) }, {each_serializer: GradingScaleIndexSerializer})
      end

      # Description of #destroy
      # @return [Type] success message
      # @author Divyanshu
      def destroy
        @grading_scale = nil
        ActiveRecord::Base.transaction do
          @grading_scale = GradingScale.find(params[:id])
          evaluation_schemes = @grading_scale.evaluation_schemes
          evaluation_schemes.update_all(grading_scale_id: nil)
          @grading_scale.destroy
          render_error(@grading_scale.errors.full_messages) and return if @grading_scale.errors.present? && grading_scale
          render_success
        end
      end

      # Description of #restore
      # @return [GradingScale] grading scale with grading scale steps
      # @author Divyanshu
      def restore
        @grading_scale = GradingScale.restore(params[:id], :recursive => true)
        render_object(@grading_scale, { name: 'grading_scale' }, {}) and return if @grading_scale.present?
        render_error(['Error occured while restoring Grading Scale'])
      end

      # Description of #update
      # @return [GradingScale] grading scale with grading scale steps
      # @author Divyanshu
      def update
        @grading_scale = GradingScale.find(params[:id])
        @grading_scale.update_attributes(grading_scale_params.merge({updated_by: User.current_user}))
        render_error(@grading_scale.errors.full_messages) and return if @grading_scale.errors.present?
        render_object(@grading_scale, { name: 'grading_scale' }, {})
      end

      # Description of #show
      # @return [GradingScale] grading scale with grading scale steps
      # @author Divyanshu
      def show
        @grading_scale = GradingScale.find(params[:id])
        render_object(@grading_scale, { name: 'grading_scale' }, {})
      end

      private

      def grading_scale_params
        params.require(:grading_scale).permit(:id, :name, :description, :grade_scale_steps, :is_for_result, :created_by, :updated_by,:lock_version)
      end



    end
