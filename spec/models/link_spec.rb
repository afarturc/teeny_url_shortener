require 'rails_helper'

RSpec.describe Link, type: :model do
  subject(:link) { create(:link) }

  describe 'validations' do
    it { expect(link).to be_valid }
    it { is_expected.to validate_presence_of(:original_url) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }

    context 'when a link is set to expire in a past date' do
      it 'raises a validation error' do
        expect { create(:link, expires_at: Date.yesterday) }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:clicks) }
  end

  describe '#expired?' do
    context 'when link is expired' do
      let(:link) { build(:link, expires_at: Date.yesterday) }
      it 'must be true' do
        expect(link.expired?).to eq(true)
      end
    end

    context 'when link is not expired' do
      let(:link) { build(:link, expires_at: Date.tomorrow) }
      it 'must be false' do
        expect(link.expired?).to eq(false)
      end
    end
  end
end
