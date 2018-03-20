    class Api::V1::GradingScaleAndStepsController < Api::V1::BaseController

      # Description of #create
      # @return [GradingScale] grading scale with grading scale steps
      # @author Divyanshu
      def create
        @grading_scale = GradingScale.create_grading_scales_with_steps(grading_scale_params)
        render_error(@grading_scale.errors.full_messages) and return if @grading_scale.errors.present?
        render_object(@grading_scale, { name: 'grading_scale' }, {})
      end

      # Description of #index
      # @return [Collection[GradingScale]] collection of grading scale with grading scale steps
      # @author Divyanshu
      def index
        @grading_scales = GradingScale.all.includes(:grading_scale_steps)
        render_collection(@grading_scales, { name: 'grading_scales' }, {})
      end

      # Description of #destroy
      # @return [Type] success message
      # @author Divyanshu
      def destroy
        @grading_scale = GradingScale.find(params[:id])
        @grading_scale.destroy
        render_error(@grading_scale.errors.full_messages) and return if @grading_scale.errors.present?
        render_success
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
        @grading_scale.update_attributes(grading_scale_params)
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
        params.require(:grading_scale).permit(:id, :name, :description, :grade_scale_steps, :is_for_result, :created_by, :updated_by)
      end
    end
