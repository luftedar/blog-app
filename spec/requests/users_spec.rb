require "rails_helper"

RSpec.describe 'Users', :type => :request do
  describe 'GET /index' do
    before(:example) {get users_path} 
    it "Successfuly get route" do
      expect(response).to have_http_status(:ok)
    end

    it "Renders 'index' template for users" do
      expect(response).to render_template('index')
    end

    it "Checks if users/index html elements rendered" do
      expect(response.body).to include("User List Page")
    end
  end
end