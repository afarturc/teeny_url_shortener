require 'rails_helper'

RSpec.describe Click, type: :model do
  subject(:click) { build(:click) }

  describe 'validations' do
    it { expect(click).to be_valid }
    it { is_expected.to validate_presence_of(:device_ip) }
    it { is_expected.to validate_presence_of(:system) }
    it { is_expected.to validate_presence_of(:language) }
    it { is_expected.to validate_presence_of(:platform) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:link) }
  end
end
