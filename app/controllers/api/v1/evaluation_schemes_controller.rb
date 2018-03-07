    class Api::V1::EvaluationSchemesController < Api::V1::BaseController

      # Description of #create
      # @return [EvaluationScheme] Returns the the new records of EvaluationScheme
      # @author Divyanshu
      def create
        @evaluation_scheme = EvaluationScheme.create_evaluation_scheme_with_terms_and_stages(evaluation_scheme_params)
        render_error(@evaluation_scheme.errors.full_messages) and return if @evaluation_scheme.errros.present?
        render_object(@evaluation_scheme, {name: 'evaluation_schemes'}, {} )
      end

      # Description of #destroy
      # @return [String] It returns the success message on deletion of record
      # @author Divyanshu
      def destroy
        ActiveRecord::Base.transaction do
          @evaluation_scheme = EvaluationScheme.find(params[:id])
          if @evaluation_scheme.destroy!
            render_success
          else
            render_error(@evaluation_scheme.errors.full_messages)
          end
        end
      end

      # Description of #index
      # @return [Collection[EvaluationScheme]] It returns the list of evaluation schemes
      # @author Divyanshu
      def index
        @evaluation_schemes = EvaluationScheme.all
        render_collection(@evaluation_schemes, { name: 'evaluation_schemes' }, {include: ['grading_scale.grading_scale_steps','evaluation_terms.evaluation_stages']} )
      end

      # Description of #show
      # @author Divyanshu
      # @return [EvaluationScheme] It returns the EvaluationScheme object
      def show
        @evaluation_scheme = EvaluationScheme.find(params[:id])
        render_object(@evaluation_scheme, { name: 'evaluation_scheme' }, {include: ['grading_scale.grading_scale_steps','evaluation_terms.evaluation_stages']})
      end

      # Description of #update
      # @author Divyanshu
      # @return [EvaluationScheme] It returns the EvaluationScheme updated object
      def update
        @evaluation_scheme = EvaluationScheme.find(params[:id])
        @evaluation_scheme.update_attributes(evaluation_scheme_params)
        render_error(@evaluation_scheme.errors.full_messages) and return if @evaluation_scheme.errors.present?
        render_object(@evaluation_scheme, { name: 'evaluation_scheme' }, {include: ['grading_scale.grading_scale_steps','evaluation_terms.evaluation_stages']})
      end


      private

      def evaluation_scheme_params
        params.require(:evaluation_scheme).permit(:id, :name, :is_active, :term_count, :stage_count,:scheme_type ,:grading_scale_id, :department_id, :academic_year_id, :created_by,
                        :updated_by,:event_marks_decimal_places,:event_scaled_marks_decimal_places,:sub_event_marks_decimal_places,:stage_marks_decimal_places,:absentee_aggregation_rule)
      end


    end
