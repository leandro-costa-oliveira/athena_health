# frozen_string_literal: true

module AthenaHealth
  class DocumentTypeCollection < BaseCollection
    attribute :documenttypes, Array[DocumentType]
  end
end
