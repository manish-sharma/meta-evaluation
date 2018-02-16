    class Api::V1::GradingScaleAndStepsController < Api::V1::BaseController

      # Description of #create
      # @author Divyanshu
      # @return [GradingScale] grading scale with grading scale steps
      def create
        ActiveRecord::Base.transaction do
          @grading_scale = GradingScale.new(grading_scale_params)
          @grading_scale.created_by = current_user
          @grading_scale.updated_by = current_user
          @grading_scale.save
          if @grading_scale.errors.present?
            render_error(@grading_scale.errors.full_messages)
          else
            @grading_scale.bulk_create(current_user)
            render_object(@grading_scale, { name: 'grading_scale' }, {})
          end
        end
      end

      # Description of #index
      # @author Divyanshu
      # @return [Collection[GradingScale]] collection of grading scale with grading scale steps
      def index
        @grading_scales = GradingScale.all.includes(:grading_scale_steps)
        render_collection(@grading_scales, { name: 'grading_scales' }, {})
      end

      # Description of #destroy
      # @author Divyanshu
      # @return [Type] success message
      def destroy
        @grading_scale = GradingScale.find(params[:id])
        @grading_scale.destroy
        if @grading_scale.errors.present?
          render_error(@grading_scale.errors.full_messages)
        else
          @grading_scale.updated_by = current_user
          @grading_scale.save
          render_success
        end
      end

      # Description of #restore
      # @author Divyanshu
      # @return [GradingScale] grading scale with grading scale steps
      def restore
        @grading_scale = GradingScale.restore(params[:id], :recursive => true)
        @grading_scale.updated_by = current_user
        @grading_scale.save
        render_object(@grading_scale, { name: 'grading_scale' }, {})
      end

      # Description of #update
      # @author Divyanshu
      # @return [GradingScale] grading scale with grading scale steps
      def update
        @grading_scale = GradingScale.find(params[:id])
        grading_scale_params[:updated_by] = current_user
        @grading_scale.update_attributes(grading_scale_params)
        if @grading_scale.errors.present?
          render_error(@grading_scale.errors.full_messages)
        else
          render_object(@grading_scale, { name: 'grading_scale' }, {})
        end
      end

      # Description of #show
      # @author Divyanshu
      # @return [GradingScale] grading scale with grading scale steps
      def show
        @grading_scale = GradingScale.find(params[:id])
        render_object(@grading_scale, { name: 'grading_scale' }, {})
      end

      private

      def grading_scale_params
        params.require(:grading_scale).permit(:id, :name, :description, :grade_scale_steps, :is_for_result)
      end
    end
