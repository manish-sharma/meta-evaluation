    class Api::V1::EvaluationComponentsController < Api::V1::BaseController

      @type_hash = {simple: 'SimpleEvaluationComponent', composite: 'CompositeEvaluationComponent', multi_occurence: 'MultiOccurenceEvaluationComponent'}

      def create
        type = @type_hash[evaluation_component_params[:type].to_sym]
        type = @type_hash[:simple] if type.nil?
        @evaluation_component = type.constantize.new(evaluation_component_params)
        if @evaluation_component.valid?
          render_object(@evaluation_component, { name: 'evaluation_component' }, {})
        else
          render_error(@evaluation_component.errors.full_messages)
        end
      end

      # def destroy
      #   @grading_scale_step = GradingScaleStep.find(params[:id])
      #   @grading_scale_step.updated_by = current_user
      #   @grading_scale_step.save
      #   @grading_scale_step.destroy
      #   if @grading_scale_step.errors.present?
      #     render_error(@grading_scale_step.errors.full_messages)
      #   else
      #     render_success
      #   end
      # end

      def show
        @evaluation_component = EvaluationComponent.find(params[:id])
        render_object(@evaluation_component, { name: 'evaluation_component' }, {})
      end

      def update
        type = @type_hash[evaluation_component_params[:type].to_sym]
        type = @type_hash[:simple] if type.nil?
        @evaluation_component = type.constantize.find(evaluation_component_params[:id])
        @evaluation_component.update_attributes(evaluation_component_params)
        if @evaluation_component.valid?
          render_object(@evaluation_component, { name: 'evaluation_component' }, {})
        else
          render_error(@evaluation_component.errors.full_messages)
        end
      end

      # def restore
      #   @grading_scale_step = GradingScaleStep.restore(params[:id])
      #   @grading_scale_step.updated_by = current_user
      #   @grading_scale_step.save
      #   render_object(@grading_scale_step, { name: 'grading_scale_step' }, {})
      # end

      private

      def evaluation_component_params
        params.require(:evaluation_component).permit(:id, :name, :type, :calculation_method, :sequence, :remarks, :code, :is_active, :parent_evaluation_component_id,:evaluation_scheme_id,:academic_year_id,:created_by, :updated_by)
      end

    end
