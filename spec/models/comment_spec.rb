require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'Comment model' do
    user = User.create(name: 'Orcun', photo: 'Cat.png', bio: 'Test Bio')
    post = Post.new(user:, title: 'test post', text: 'Testing post')
    comment = Comment.new(user:, post:, text: 'Test Comment')
    comment.update_comments_counter

    it 'Check Comments Counter' do
      current = post.comments_counter
      comment_new = Comment.new(user:, post:, text: 'New Test Comment')
      comment_new.update_comments_counter
      expect(post.comments_counter).to eq(current + 1)
    end
  end
end
