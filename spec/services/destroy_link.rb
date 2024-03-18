require 'rails_helper'

RSpec.describe DestroyLink do
  let(:destroy_link) { described_class.new(link).perform }

  describe '#perform' do
    context 'when book exists' do
      let(:link) { create(:link) }

      it 'destroys the book' do
        aggregate_failures do
          expect(destroy_link.success?).to eq(true)
          expect { link.reload }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end
  end
end
