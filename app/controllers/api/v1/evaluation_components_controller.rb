class Api::V1::EvaluationComponentsController < Api::V1::BaseController

  #constants
    TYPE_HASH = {'simple'=> 'SimpleEvaluationComponent', 'composite'=> 'CompositeEvaluationComponent', 'multi_occurence'=> 'MultiOccurenceEvaluationComponent'}

      def index
        @evaluation_scheme = EvaluationScheme.find(params[:evaluation_scheme_id])
        render_collection(@evaluation_scheme.evaluation_components.parent_evaluation_components.sequence_sorted, {name: 'evaluation_components'},{include: ['sub_components','evaluation_component_term_stage_details','sub_components.evaluation_component_term_stage_details'],each_serializer: EvaluationComponentSerializer})
      end


      def create
        @evaluation_component=nil
        klass = TYPE_HASH[evaluation_component_params['component_type'] || 'simple'].constantize
        parameters = evaluation_component_params.to_h.except!('component_type')
        parameters[:evaluation_scheme_id] = params[:evaluation_scheme_id]
        if klass.name != "CompositeEvaluationComponent"
          @evaluation_component = EvaluationComponent.create_evaluation_component_with_marks(klass,parameters, evaluation_component_term_stage_detail_params)
          render_object(@evaluation_component, { name: 'evaluation_component' }, {}) and return if @evaluation_component.present?
        else
          @evaluation_component = klass.create(parameters)
          render_object(@evaluation_component, { name: 'evaluation_component' }, {}) and return if @evaluation_component.valid?
        end
        render_error(@evaluation_component.errors.full_messages)
      end

      def destroy
        @evaluation_component = EvaluationComponent.find(params[:id])
        @evaluation_component.destroy
        render_error(@evaluation_component.errors.full_messages) and return if @evaluation_component.errors.present?
        render_success
      end

      def show
        @evaluation_component = EvaluationComponent.find(params[:id])
        render_object(@evaluation_component, { name: 'evaluation_component' }, {})
      end

      def update
        @evaluation_component =  EvaluationComponent.update_evaluation_component_with_marks(params[:id],evaluation_component_params,evaluation_component_term_stage_detail_params)
        render_object(@evaluation_component, { name: 'evaluation_component' }, {}) and return if @evaluation_component.present?
        render_error(@evaluation_component.errors.full_messages)
      end



      private

      def evaluation_component_params
        params.require(:evaluation_component).permit(:id, :name, :component_type,:type, :calculation_method, :sequence, :remarks, :code, :is_active, :parent_evaluation_component_id,:evaluation_scheme_id,:academic_year_id,:created_by, :updated_by,:parent_evaluation_component_id)
      end

      def evaluation_component_term_stage_detail_params
        params.permit(:evaluation_component_term_stage_details => [:id,:evaluation_stage_id,:max_marks])
      end

    end
