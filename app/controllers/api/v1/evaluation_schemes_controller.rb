    class Api::V1::EvaluationSchemesController < Api::V1::BaseController

      before_action :convert_absentee_aggreagtion_rule_and_scheme_type, only: [:create,:update]

      # Description of #create
      # @return [EvaluationScheme] Returns the the new records of EvaluationScheme
      # @author Divyanshu
      def create
        @evaluation_scheme = EvaluationScheme.create_evaluation_scheme_with_terms_and_stages(evaluation_scheme_params)
        render_error(@evaluation_scheme.errors.full_messages) and return if @evaluation_scheme.errors.present?
        render_object(@evaluation_scheme, {name: 'evaluation_scheme'}, {include: ['grading_scale','evaluation_terms.evaluation_stages']} )
      end

      # Description of #destroy
      # @return [String] It returns the success message on deletion of record
      # @author Divyanshu
      def destroy
          @evaluation_scheme = EvaluationScheme.find(params[:id])
          render_success and return if @evaluation_scheme.destroy!
          render_error(@evaluation_scheme.errors.full_messages)
      end

      # Description of #index
      # @return [Collection[EvaluationScheme]] It returns the list of evaluation schemes
      # @author Divyanshu
      def index
        @evaluation_schemes = EvaluationScheme.page(params[:page])
        render_collection(@evaluation_schemes, { name: 'evaluation_schemes' ,pagination: pagination_info(@evaluation_schemes)}, {include: ['grading_scale','evaluation_terms.evaluation_stages'], each_serializer: EvaluationSchemeIndexSerializer} )
      end

      # Description of #show
      # @author Divyanshu
      # @return [EvaluationScheme] It returns the EvaluationScheme object
      def show
        @evaluation_scheme = EvaluationScheme.find(params[:id])
        render_object(@evaluation_scheme, { name: 'evaluation_scheme' }, {include: ['grading_scale','evaluation_terms.evaluation_stages', 'evaluation_components.parent_evaluation_components', 'evaluation_components.evaluation_component_term_stage_details']})
      end

      # Description of #update
      # @author Divyanshu
      # @return [EvaluationScheme] It returns the EvaluationScheme updated object
      def update
        @evaluation_scheme = EvaluationScheme.find(params[:id])
        @evaluation_scheme.update_attributes(evaluation_scheme_params.merge({updated_by: User.current_user}))
        render_error(@evaluation_scheme.errors.full_messages) and return if @evaluation_scheme.errors.present?
        render_object(@evaluation_scheme, { name: 'evaluation_scheme' }, {include: ['grading_scale.grading_scale_steps','evaluation_terms.evaluation_stages']})
      end

      def data_for_new_es
        data= { absentee_aggregation_rules: EvaluationScheme.absentee_aggregation_rules.keys.map{|t| t.titlecase}, scheme_types: EvaluationScheme.scheme_types.keys.map{|t| t.titlecase}}
        render json: data, status: :ok
      end


      # Description of #apply_evaluation_scheme
      # @return [String] sucess or error message
      # @author Divyanshu
      def apply_evaluation_scheme

      end

      private

      def evaluation_scheme_params
        params.require(:evaluation_scheme).permit(:id, :name, :is_active,:is_practical, :term_count, :stage_count,:scheme_type ,:grading_scale_id, :department_id, :academic_year_id, :created_by,
                        :updated_by,:event_marks_decimal_places,:event_scaled_marks_decimal_places,:sub_event_marks_decimal_places,:stage_marks_decimal_places,:absentee_aggregation_rule,:lock_version)
      end

      def convert_absentee_aggreagtion_rule_and_scheme_type
        params["evaluation_scheme"]["scheme_type"] = params["evaluation_scheme"]["scheme_type"].try(:delete,' ').try(:underscore)
        params["evaluation_scheme"]["absentee_aggregation_rule"] = params["evaluation_scheme"]["absentee_aggregation_rule"].try(:delete, ' ').try(:underscore)
      end


    end
