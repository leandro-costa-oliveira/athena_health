# frozen_string_literal: true

module AthenaHealth
  module Endpoints
    module Documents
      def all_document_types(practice_id:, search_value:, params: {})
        params[:searchvalue] = search_value

        response = @api.call(
          endpoint: "#{practice_id}/documenttypes",
          method: :get,
          params:
        )

        DocumentTypeCollection.new(response)
      end
    end
  end
end
