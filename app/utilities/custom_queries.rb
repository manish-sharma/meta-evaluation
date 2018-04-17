class CustomQueries

  # Method to return component details
  # component_details shall contains evaluation_terms, its evaluation_stages and their max_marks.
  #
  # @param [Integer] component_id id of the component to be fetched
  # @return [JSON String] return component object
  # @author Shobhit Dixit
  def self.get_component_by_id(component_id)
    ActiveRecord::Base.connection.execute(
    "SELECT evaluation_components.id        AS id,
       evaluation_components.NAME      AS NAME, evaluation_components.evaluation_scheme_id,
       evaluation_components.type, evaluation_components.calculation_method,
       evaluation_components.evaluation_group, evaluation_components.category,
       evaluation_components.report_card_name, evaluation_components.sequence,
       evaluation_components.remarks, evaluation_components.code,
       evaluation_components.is_active, evaluation_components.lock_version,
       (SELECT Array_to_json(Array_agg(Row_to_json(terms)))
        FROM   (SELECT evaluation_terms.id         AS id,
                       evaluation_terms.NAME       AS NAME,
                       (SELECT Array_to_json(Array_agg(Row_to_json(esm)))
                        FROM   (SELECT evaluation_stages.id   AS id,
                                       evaluation_stages.NAME AS NAME,
       evaluation_component_term_stage_details.max_marks
       FROM   evaluation_stages
       JOIN evaluation_component_term_stage_details
         ON
       evaluation_component_term_stage_details.evaluation_stage_id
       =
       evaluation_stages.id
       WHERE  evaluation_stages.evaluation_term_id =
       evaluation_terms.id
       ORDER  BY id) esm) AS evaluation_stages
       FROM   evaluation_terms WHERE  evaluation_terms.evaluation_scheme_id =
       evaluation_components.evaluation_scheme_id) terms) AS evaluation_term_stage_details
    FROM   evaluation_components where evaluation_components.id=#{component_id}
    and #{current_tenant} and #{not_deleted} limit 1
    ").as_json.first
  end


  # Private methods of the class CustomQueries.
  #
  # @author Shobhit Dixit
  class << self

    private

    def current_tenant
      begin
        " organization_id=#{ActsAsTenant.current_tenant.id}"
      rescue Exception => e
        raise ActsAsTenant::Errors::NoTenantSet
      end
    end

    def not_deleted
      " deleted_at is NULL"
    end

  end
end
