require 'spec_helper'

describe AthenaHealth::DocumentType do
  let(:document_type_attributes) do
    {
      "documenttypeid": 387756,
      "name": "(INPT_NURSING_REPEATING): CUSTOM NURSING ORDER"
    }
  end

  subject { AthenaHealth::DocumentType.new(document_type_attributes) }

  it_behaves_like 'a model'

  it 'have proper attributes' do
    expect(subject).to have_attributes(
      documenttypeid: 387756,
      name: '(INPT_NURSING_REPEATING): CUSTOM NURSING ORDER',
    )
  end
end
