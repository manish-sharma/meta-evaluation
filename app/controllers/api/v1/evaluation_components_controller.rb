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
        @evaluation_scheme = EvaluationScheme.find(params[:evaluation_scheme_id])
        if klass.name != "CompositeEvaluationComponent"
          @evaluation_component = EvaluationComponent.create_evaluation_component_with_marks(klass,parameters)
          render_collection(@evaluation_scheme.evaluation_components, { name: 'evaluation_components' }, {}) and return if @evaluation_component.valid?
        else
          @evaluation_component = klass.new(parameters)
          render_object(@evaluation_component, { name: 'evaluation_component' }, {}) and return if @evaluation_component.save
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
        # @evaluation_component = EvaluationComponent.find(params[:id])
        # render_object(@evaluation_component, { name: 'evaluation_component' }, {})
        component = CustomQueries.get_component_by_id params[:id]
        component["evaluation_term_stage_details"] = ActiveSupport::JSON.decode component["evaluation_term_stage_details"]
        render json: component, status: :ok
      end

      def update
        @evaluation_component =  EvaluationComponent.update_evaluation_component_with_marks(params[:id],evaluation_component_params)
        render_error(@evaluation_component.errors.full_messages) and return if @evaluation_component.errors.present?
        component = CustomQueries.get_component_by_id params[:id]
        component["evaluation_term_stage_details"] = ActiveSupport::JSON.decode component["evaluation_term_stage_details"]
        render json: component, status: :ok
      end



      private


      # TODO: Add require(:evaluation_component)
      def evaluation_component_params
        params.permit(:id, :name, :component_type,:type, :calculation_method, :sequence, :remarks,
                :code, :is_active, :parent_evaluation_component_id,:evaluation_scheme_id,:parent_evaluation_component_id,:category,
                :evaluation_group,:report_card_name,:lock_version,
                evaluation_component_term_stage_details_attributes: [:id,:evaluation_stage_id,:max_marks,:lock_version])
      end

      # def evaluation_component_term_stage_detail_params
      #   params.permit(:evaluation_component_term_stage_details => [:id,:evaluation_stage_id,:max_marks,:lock_version])
      # end







      # def special_show(id)
      #   records = EvaluationComponent.select('evaluation_components.id as ec_id,evaluation_components.type as ec_type,evaluation_components.*,evaluation_terms.id as term_id,evaluation_terms.name as term_name, evaluation_stages.id as stage_id,ectsd.max_marks,evaluation_terms.sequence as term_sequence,evaluation_stages.name as stage_name,evaluation_stages.sequence as stage_sequence')
      #   .joins(evaluation_scheme: [evaluation_terms: [:evaluation_stages]])
      #   .joins('LEFT OUTER JOIN evaluation_component_term_stage_details as ectsd ON ectsd.evaluation_component_id = evaluation_components.id AND ectsd.evaluation_stage_id=evaluation_stages.id')
      #   .group('ec_id,evaluation_terms.id,evaluation_stages.id,ectsd.max_marks').order('evaluation_terms.sequence,evaluation_stages.sequence')
      #   .where(id: id).as_json.map{|r| r.deep_symbolize_keys}
      #   result = {}
      #   result[:evaluation_component]={}
      #   records.each do |r|
      #
      #     # add component detail in hash if not present
      #     if !result[:evaluation_component].has_key?(:id)
      #       result[:evaluation_component] = {
      #         id: r[:ec_id],
      #         name: r[:name],
      #         type: r[:ec_type],
      #         is_active: r[:is_active],
      #         calculation_method: r[:calculation_method],
      #         evaluation_group: r[:evaluation_group]
      #       }
      #     end
      #
      #     # check for component has attribute evaluation_terms
      #     if result[:evaluation_component].has_key?(:evaluation_term_stage_details)
      #       if !result[:evaluation_component][:evaluation_term_stage_details].pluck(:id).include? r[:term_id]
      #         result[:evaluation_component][:evaluation_term_stage_details]<<{
      #           id: r[:term_id],
      #           name: r[:term_name]
      #         }
      #       end
      #     else
      #       result[:evaluation_component][:evaluation_term_stage_details]=[]
      #       result[:evaluation_component][:evaluation_term_stage_details]<<{
      #         id: r[:term_id],
      #         name: r[:term_name]
      #       }
      #     end
      #
      #
      #
      #     # check for component has attribute evaluation_terms
      #     index = result[:evaluation_component][:evaluation_term_stage_details].pluck(:id).index(r[:term_id])
      #     if result[:evaluation_component][:evaluation_term_stage_details][index].has_key?(:evaluation_stages)
      #       if !result[:evaluation_component][:evaluation_term_stage_details][index][:evaluation_stages].pluck(:id).include? r[:stage_id]
      #         result[:evaluation_component][:evaluation_term_stage_details][index][:evaluation_stages]<<{
      #           id: r[:stage_id],
      #           name: r[:stage_name],
      #           max_marks: r[:max_marks]
      #         }
      #       end
      #     else
      #       result[:evaluation_component][:evaluation_term_stage_details][index][:evaluation_stages]=[]
      #       result[:evaluation_component][:evaluation_term_stage_details][index][:evaluation_stages]<<{
      #         id: r[:stage_id],
      #         name: r[:stage_name],
      #         max_marks: r[:max_marks]
      #       }
      #     end
      #   end
      #     result
      # end

    end
