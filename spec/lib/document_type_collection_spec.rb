require 'spec_helper'

describe AthenaHealth::DocumentTypeCollection do
  let(:document_type_collection_attributes) do
    {
      'totalcount': 1,
      'next': 'next_page_url',
      'previous': 'previous_page_url',
      'documenttypes': [{
        "documenttypeid": 387756,
        "name": "(INPT_NURSING_REPEATING): CUSTOM NURSING ORDER"
      }]
    }
  end

  subject { AthenaHealth::DocumentTypeCollection.new(document_type_collection_attributes) }

  it_behaves_like 'a collection'

  it 'have proper attributes' do
    expect(subject.documenttypes.map(&:class)).to eq [AthenaHealth::DocumentType]
  end
end
