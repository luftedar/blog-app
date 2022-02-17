require "rails_helper"

RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    before(:example) { get user_posts_path(1) }

    it "Checks if status correct" do
      expect(response).to have_http_status(:ok)
    end

    it "Renders 'index' template for posts" do
      expect(response).to render_template('index')
    end

    it "Checks if response body includes correct placeholder text" do
      expect(response.body).to include("Show User's All Post")
    end
  end
end