    class Api::V1::GradingScaleStepsController < Api::V1::BaseController
      def create
        @grading_scale_step = GradingScaleStep.new(grading_scale_step_params)
        @grading_scale_step.created_by = current_user
        @grading_scale_step.updated_by = current_user
        @grading_scale_step.save
        if @grading_scale_step.errors.present?
          render_error(@grading_scale_step.errors.full_messages)
        else
          render_object(@grading_scale_step, { name: 'grading_scale_step' }, {})
        end
      end

      def destroy
        @grading_scale_step = GradingScaleStep.find(params[:id])
        @grading_scale_step.destroy
        if @grading_scale_step.errors.present?
          render_error(@grading_scale_step.errors.full_messages)
        else
          @grading_scale_step.updated_by = current_user
          @grading_scale_step.save
          render_success
        end
      end

      def show
        @grading_scale_step = GradingScaleStep.find(params[:id])
        render_object(@grading_scale_step, { name: 'grading_scale_step' }, {})
      end

      def update
        @grading_scale_step = GradingScaleStep.find(params[:id])
        grading_scale_step_params[:updated_by] = current_user
        @grading_scale_step.update_attributes(grading_scale_step_params)
        if @grading_scale_step.errors.present?
          render_error(@grading_scale_step.errors.full_messages)
        else
          render_object(@grading_scale_step, { name: 'grading_scale_step' }, {})
        end
      end

      def restore
        @grading_scale_step = GradingScaleStep.restore(params[:id])
        @grading_scale_step.updated_by = current_user
        @grading_scale_step.save
        render_object(@grading_scale_step, { name: 'grading_scale_step' }, {})
      end

      private

      def grading_scale_step_params
        params.require(:grading_scale_step).permit(:id, :maximum, :minimum, :step_display, :numeric_display, :step_weight, :grading_scale_id)
      end

    end
