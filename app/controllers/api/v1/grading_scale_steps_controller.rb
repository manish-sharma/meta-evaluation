    class Api::V1::GradingScaleStepsController < Api::V1::BaseController


      # Description of #create
      # @return [GradingScaleStep] returns GradingScaleStep list
      # @author Divyanshu
      def index
        @grading_scale = GradingScale.find(params[:grading_scale_id])
        @grading_scale_steps = @grading_scale.grading_scale_steps
        render_collection(@grading_scale_steps, { name: 'grading_scale_steps' }, {})
      end


      # Description of #create
      # @return [GradingScaleStep] returns created GradingScaleStep object
      # @author Divyanshu
      def create
        @grading_scale = GradingScale.find(params[:grading_scale_id])
        @grading_scale_step = @grading_scale.grading_scale_steps.create(grading_scale_step_params)
        render_error(@grading_scale_step.errors.full_messages) and return if @grading_scale_step.errors.present?
        render_collection(@grading_scale.grading_scale_steps, { name: 'grading_scale_steps' }, {})
      end

      # Description of #destroy
      # @return [String] Success Message on successful deletion
      # @author Divyanshu
      def destroy
        @grading_scale_step = GradingScaleStep.find(params[:id])
        @grading_scale_step.destroy
        render_error(@grading_scale_step.errors.full_messages) if @grading_scale_step.errors.present?
        render_success
      end

      # Description of #show
      # @return [GradingScaleStep] grading scale steps details
      # @author Divyanshu
      def show
        @grading_scale_step = GradingScaleStep.find(params[:id])
        render_collection(@grading_scale_step, { name: 'grading_scale_step' }, {})
      end

      # Description of #update
      # @return [GradingScaleStep] updated GradingScaleStep object
      # @author Divyanshu
      def update
        @grading_scale = GradingScale.find(params[:grading_scale_id])
        @grading_scale_step = GradingScaleStep.find(params[:id])
        @grading_scale_step.update_attributes(grading_scale_step_params)
        render_error(@grading_scale_step.errors.full_messages) and return if @grading_scale_step.errors.present?
        render_collection(@grading_scale.grading_scale_steps, { name: 'grading_scale_steps' }, {})
      end

      # Description of #restore
      # @return [GradingScaleStep] restored GradingScaleStep object
      # @author Divyanshu
      def restore
        @grading_scale_step = GradingScaleStep.restore(params[:id])
        render_object(@grading_scale_step, { name: 'grading_scale_step' }, {})
      end


      def colors_results
        render json: {colors: GradingScaleStep.colors.keys, results: GradingScaleStep.results.keys}, status: :ok
      end

      private

      def grading_scale_step_params
        params.require(:grading_scale_step).permit(:id, :maximum, :minimum, :step_display_name, :numeric_display, :step_weight, :grading_scale_id,:created_by, :updated_by, :result, :color,:lock_version)
      end

    end
