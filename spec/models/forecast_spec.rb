require 'rails_helper'

RSpec.describe Forecast, type: :model do
  context 'validations' do
    it { should validate_presence_of(:data) }
    it { should validate_presence_of(:postal_code) }
  end
end
