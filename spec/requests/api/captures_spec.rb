require('rails_helper')

RSpec.describe('Captures', type: :request) do
  let(:user) { create(:user) }

  let(:headers) { authenticated_headers(user: user) }
  let(:params) { {} }

  before do
    3.times { |i| user.captures.create!(pokemon: create(:pokemon), level: i+1) }
  end

  describe('index') do
    let(:expected) do
      {
        count: user.captures.size,
        page: 1,
        per_page: 20,
        results: ActiveModel::SerializableResource.new(user.captures).as_json
      }
    end

    before do
      get('/api/captures', headers: headers)
    end

    it('fetches the user captures') do
      expect(JSON.parse(response.body, symbolize_names: true)).to eq(expected)
    end
  end

end
