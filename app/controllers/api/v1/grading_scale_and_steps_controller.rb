module API
  module V1
    class GradingScaleAndStepsController < ApplicationController


      # Description of #create
      # @author Divyanshu
      # @return [GradingScale] grading scale with grading scale steps
      def create
        @grading_scale = GradingScale.create(grading_scale_params)
        @grading_scale.save
        if @grading_scale.errors.present?
          render_error(@grading_scale.errors.full_messages)
        else
          @grading_scale.bulk_create
          render_object(@grading_scale, { name: 'grading_scale' }, {})
        end
      end

      # Description of #index
      # @author Divyanshu
      # @return [Collection[GradingScale]] description_of_returned_object
      def index
        @grading_scales = GradingScale.all.includes(:grading_scale_steps)
        render_collection(@grading_scales, { name: 'grading_scales' }, {})
      end

      def destroy
        @grading_scale = GradingScale.find(params[:id])
        @grading_scale.destroy
        render_object(@grading_scale)
      end

      def restore
        @grading_scale = GradingScale.restore(params[:id], :recursive => true)
        @grading_scale = @grading_scale.includes(:grading_scale_steps)
        render_object(@grading_scale, { name: 'grading_scale' }, {})
      end

      def update
        @grading_scale = GradingScale.find(params[:id])
        @grading_scale.update_attributes(grading_scale_params)
        @grading_scale = @grading_scale.includes(:grading_scale_steps)
        render_object(@grading_scale, { name: 'grading_scale' }, {})
      end

      def show
        @grading_scale = GradingScale.find(params[:id]).includes(:grading_scale_steps)
        render_object(@grading_scale, { name: 'grading_scale' }, {})
      end
      private

      def grading_scale_params
        params.require(:grading_scale).permit(:id, :name, :description, :grading_scale_steps, :is_for_result)
      end
    end
  end
end
