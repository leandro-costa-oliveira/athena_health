require 'spec_helper'

describe AthenaHealth::Endpoints::Documents do
  describe '#all_document_types' do
    let(:attributes) do
      {
        practice_id: 195_900,
        search_value: 'order'
      }
    end

    it 'returns a collection of DocumentType' do
      VCR.use_cassette('all_document_types') do
        expect(client.all_document_types(**attributes)).to be_an_instance_of AthenaHealth::DocumentTypeCollection
      end
    end
  end
end
