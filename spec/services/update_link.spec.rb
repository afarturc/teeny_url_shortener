# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpdateLink do
  let(:link) { create(:link) }
  let(:update_link) { described_class.new(link, link_params).perform }

  describe '#perform' do
    let!(:user_id) { create(:user).id }
    context 'when params are valid' do
      let(:link_params) do
        {
          name: FFaker::Lorem.word,
          description: FFaker::Lorem.sentence
        }
      end

      it 'updates a link' do
        aggregate_failures do
          expect(update_link.success?).to eq(true)
          expect(Link.last.name).to eq(link_params[:name])
          expect(Link.last.description).to eq(link_params[:description])
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
        ["Original url can't be blank"]
      end

      it 'does not update a link' do
        aggregate_failures do
          expect(create_link.success?).to eq(false)
          expect(create_link.errors).to eq(expected_error_messages)
        end
      end
    end
  end
end
