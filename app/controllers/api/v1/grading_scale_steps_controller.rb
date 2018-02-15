module API
  module V1
    class GradingScaleStepsController < ApplicationController
      def create
        @grading_scale_step = GradingScaleStep.create(grading_scale_step_params)
        if @grading_scale_step.errors.size.positive?
          render_error(@grading_scale_step.errors.full_messages)
        else
          render_object(@grading_scale_step, { name: 'grading_scale_step' }, {})
        end
      end

      def destroy
        @grading_scale_step = GradingScaleStep.find(params[:id])
        @grading_scale_step.destroy
        if @grading_scale_step.errors.size.positive?
          render_error(@grading_scale_step.errors.full_messages)
        else
          render_object(@grading_scale_step, { name: 'grading_scale_step' }, {})
        end
      end

      def show
        @grading_scale_step = GradingScaleStep.find(params[:id])
        render_object(@grading_scale_step, { name: 'grading_scale_step' }, {})
      end

      def update
        @grading_scale_step = GradingScaleStep.find(params[:id])
        @grading_scale_step.update_attributes(grading_scale_step_params)
        if @grading_scale_step.errors.size.positive?
          render_error(@grading_scale_step.errors.full_messages)
        else
          render_object(@grading_scale_step, { name: 'grading_scale_step' }, {})
        end
      end

      def restore
        @grading_scale_step = GradingScale.restore(params[:id])
        render_object(@grading_scale_step, { name: 'grading_scale_step' }, {})
      end

      private

      def grading_scale_step_params
        params.require(:grading_scale_step).permit(:id, :maximum, :minimum, :step_display, :numeric_display, :step_weight, :grading_scale_id)
      end
    end
  end
end
