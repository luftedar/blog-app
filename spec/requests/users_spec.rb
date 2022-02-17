require "rails_helper"

RSpec.describe 'Users', :type => :request do
  describe 'GET /index' do
    before(:example) {get users_path} 
    it "Successfuly get route" do
      expect(response).to have_http_status(:ok)
    end

    it "renders 'index' template for users" do
      expect(response).to render_template('index')
    end
  end
end