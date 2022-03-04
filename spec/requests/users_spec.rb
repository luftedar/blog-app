require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    it 'should returns http 200 success' do
      get users_path
      expect(response).to have_http_status(200)
    end

    it 'should include Number of posts' do
      get users_path
      expect(response.body).to include('Number of Posts:')
    end
  end

  describe 'GET /show' do
    user = User.create('name' => 'Heyo', 'bio' => 'alive', 'photo' => 'Cat.png', 'posts_counter' => 0)
    before(:each) { get user_path id: user.id }

    it 'should return correct response' do
      expect(response).to have_http_status(200)
    end

    it 'should render the show template ' do
      expect(response).to render_template(:show)
    end
  end
end
