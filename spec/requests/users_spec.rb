require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    before(:example) { get '/users' }
    it 'Successfuly get route' do
      expect(response).to have_http_status(:ok)
    end

    it "Renders 'index' template for users" do
      expect(response).to render_template('index')
    end

    it 'Checks if users/index html elements rendered' do
      expect(response.body).to include('User List Page')
    end
  end

  describe 'GET /show' do
    before(:example) { get '/users/1' }

    it 'Response status correct' do
      expect(response).to have_http_status(:ok)
    end

    it "Renders 'show' template for users" do
      expect(response).to render_template('show')
    end

    it 'Checks if response body includes correct placeholder text' do
      expect(response.body).to include('Specific User Page')
    end
  end
end
