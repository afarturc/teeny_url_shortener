# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateLink do
  let(:create_link) { described_class.new(link_params, user_id).perform }

  describe '#perform' do
    let!(:user_id) { create(:user).id }
    context 'when params are valid' do
      let(:link_params) do
        {
          original_url: FFaker::Internet.http_url
        }
      end

      it 'creates a link' do
        aggregate_failures do
          expect { create_link }.to change(Link, :count).by(1)
          expect(create_link.success?).to eq(true)
        end
      end
    end

    context 'when params are invalid' do
      let(:link_params) do
        {
          original_url: nil
        }
      end
      let(:expected_error_messages) do
        ["Original url can't be blank", "Short url can't be blank"]
      end

      it 'creates a link' do
        aggregate_failures do
          expect { create_link }.not_to change(Link, :count)
          expect(create_link.success?).to eq(false)
          expect(create_link.errors).to eq(expected_error_messages)
        end
      end
    end
  end
end
