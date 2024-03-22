# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ClicksLast30Days do
  let(:clicks_last_30_days) { described_class.new(link).perform }

  describe '#perform' do
    let!(:link) { create(:link) }

    context 'when clicks are found' do
      before do
        10.times { create(:click, link_id: link.id, created_at: rand(30).days.ago) }
      end

      it 'returns the count of clicks for the last 30 days' do
        aggregate_failures do
          expect(clicks_last_30_days.success?).to eq(true)
          expect(clicks_last_30_days.clicks).to be_present
        end
      end
    end

    context 'when clicks are not found' do
      it 'does not return clicks' do
        aggregate_failures do
          expect(clicks_last_30_days.success?).to eq(false)
          expect(clicks_last_30_days.clicks).not_to be_present
        end
      end
    end
  end
end
