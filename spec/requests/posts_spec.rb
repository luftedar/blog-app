require "rails_helper"

RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    before(:example) { get user_posts_path(1) }

    it "Checks if status correct" do
      expect(response).to have_http_status(:ok)
    end
  end
end