    class Api::V1::EvaluationSchemesController < Api::V1::BaseController

      # Description of #create
      # @author Divyanshu
      # @return [EvaluationScheme] Returns the the new records of EvaluationScheme
      def create
        @evaluation_scheme = nil
        ActiveRecord::Base.transaction do
          begin
            @evaluation_scheme = EvaluationScheme.new(evaluation_scheme_params)
          rescue ArgumentError
            render_error(['Invalid Scheme Type']) and return
          end
          if @evaluation_scheme.valid?
            @evaluation_scheme.save!
            @evaluation_scheme.bulk_create_terms_and_stages(evaluation_scheme_params[:academic_year_id], evaluation_scheme_params[:created_by])
            render_object(@evaluation_scheme, { name: 'evaluation_scheme' }, {include: ['grading_scale.grading_scale_steps','evaluation_terms.evaluation_stages']})
          else
            render_error(@evaluation_scheme.errors.full_messages)
          end
        end
      end

      # Description of #destroy
      # @author Divyanshu
      # @return [String] It returns the success message on deletion of record
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
      # @author Divyanshu
      # @return [Collection[EvaluationScheme]] It returns the list of evaluation schemes
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
        if @evaluation_scheme.invalid?
          render_error(@evaluation_scheme.errors.full_messages)
        else
          render_object(@evaluation_scheme, { name: 'evaluation_scheme' }, {include: ['grading_scale.grading_scale_steps','evaluation_terms.evaluation_stages']})
        end
      end


      private

      def evaluation_scheme_params
        params.require(:evaluation_scheme).permit(:id, :name, :is_active, :term_count, :stage_count,:scheme_type ,:grading_scale_id, :department_id, :academic_year_id, :created_by,
                        :updated_by,:event_marks_decimal_places,:event_scaled_marks_decimal_places,:sub_event_marks_decimal_places,:stage_marks_decimal_places,:absentee_aggregation_rule)
      end


    end
