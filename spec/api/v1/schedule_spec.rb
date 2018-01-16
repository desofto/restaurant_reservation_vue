require 'rails_helper'

describe API::V1::Schedule, type: :api do
  describe 'GET /api/v1/schedule/:month' do
    it 'returns free seats count for the month' do
      date = Time.zone.today.beginning_of_month
      create(:schedule, date: date + 20.days, count: 10)
      create(:schedule, date: date + 21.days, count: 15)

      get "/api/v1/schedule/#{date.year}/#{date.month}"

      expect(response.status).to eq 200
      expect(json.count).to eq 2
      expect(json[0]).to include({ 'day' => 21, 'count' => 10 })
      expect(json[1]).to include({ 'day' => 22, 'count' => 15 })
    end
  end
end
