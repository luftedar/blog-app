require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'posts comments' do
    author = User.new(name: 'Tom', photo: 'Cat.png', bio: 'bio', posts_counter: 0)
    post = Post.new(title: 'New post', text: 'Good evening', user: author, likes_counter: 0, comments_counter: 0)
    post.save!
    
    comment_creator = User.new(name: 'Jerry', photo: 'Cat.png', bio: 'bio', posts_counter: 0)
    post.comments.create!(text: 'This is my first post', user: comment_creator)
    post.comments.create!(text: 'This is my second post', user: comment_creator)
    expect(post.comments.length).to eql(2)
  end
end