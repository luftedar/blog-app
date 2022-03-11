require 'rails_helper'

RSpec.describe Like, type: :model do
  before(:each) do
    @user = User.create(id: 1, name: 'Orcun', photo: 'Cat.png',
                        bio: 'Test Bio')
    @post = Post.create(user: @user, title: 'Test title', text: 'Test Text', likes_counter: 5)
    @like = Like.new(user_id: @user.id, post_id: @user.id)
  end

  describe 'Tests' do
    it 'validates the user_id' do
      expect(@like.user_id).to eq(1)
    end

    it 'validates the post_id' do
      expect(@like.post_id).to eq(1)
    end
  end

  describe 'like model methods tests' do
    it 'should increment likes_counter' do
      @like.save
      expect(@post.likes_counter).to eq(5)
    end
  end
end
