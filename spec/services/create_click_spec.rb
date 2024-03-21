# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateClick do
  let(:create_click) { described_class.new(link, click_params).perform }

  describe '#perform' do
    let!(:link) { create(:link) }
    context 'when params are valid' do
      let(:click_params) { attributes_for(:click) }

      it 'creates a click' do
        aggregate_failures do
          expect { create_click }.to change(Click, :count).by(1)
          expect(create_click.success?).to eq(true)
        end
      end
    end

    context 'when params are invalid' do
      let(:click_params) { attributes_for(:click, system: nil, platform: nil) }
      let(:expected_error_messages) do
        ["System can't be blank", "Platform can't be blank"]
      end

      it 'does not create a click' do
        aggregate_failures do
          expect { create_click }.not_to change(Click, :count)
          expect(create_click.success?).to eq(false)
          expect(create_click.errors).to eq(expected_error_messages)
        end
      end
    end
  end
end
