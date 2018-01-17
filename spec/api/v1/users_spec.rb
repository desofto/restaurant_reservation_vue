require 'rails_helper'

describe API::V1::Users, type: :api do
  describe 'POST /api/v1/users' do
    it 'authenticate user with valid password' do
      user = create(:user, email: 'test@gmail.com', password: 'qweQWE123')

      post '/api/v1/users', params: { email: 'test@gmail.com', password: 'qweQWE123' }

      expect(response.status).to eq 201
      expect(json['token']).to eq user.reload.token
    end

    it 'returns error on invalid password' do
      user = create(:user, email: 'test@gmail.com', password: 'qweQWE123')

      post '/api/v1/users', params: { email: 'test@gmail.com', password: '123' }

      expect(response.status).to eq 401
      expect(json['errors']).not_to be_empty
    end
  end
end
