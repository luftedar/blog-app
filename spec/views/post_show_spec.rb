require 'rails_helper'

RSpec.describe 'Post_Show', type: :feature do
  describe 'Post&User' do
    before(:each) do
      @user1 = User.create(name: 'first', password: '123456', bio: 'I am the first user',
                           email: 'first@first.com', confirmed_at: Time.now)
      visit root_path
      fill_in 'Email', with: 'first@first.com'
      fill_in 'Password', with: '123456'
      click_button 'Log in'

      @post1 = Post.create(title: 'First Post',
                           text: 'This is the first post',
                           comments_counter: 0, likes_counter: 0, user: @user1)
      @post2 = Post.create(title: 'Second Post',
                           text: 'This is the second post',
                           comments_counter: 0,
                           likes_counter: 0, user: @user1)
      @post3 = Post.create(title: 'Third Post',
                           text: 'This is the third post',
                           comments_counter: 0,
                           likes_counter: 0, user: @user1)

      @comment1 = Comment.create(text: 'This is the first comment for the first post', user: User.first,
                                 post: Post.first)
      @comment2 = Comment.create(text: 'This is the second comment', user: User.first, post: Post.first)
      @comment3 = Comment.create(text: 'This is the third comment', user: User.first, post: Post.first)

      visit user_post_path(@user1, @post1)
    end

    it 'shows the post owner' do
      expect(page).to have_content('first')
    end

    it 'shows the number of comments' do
      post = Post.first
      expect(page).to have_content(post.comments_counter)
    end

    it 'shows the post title' do
      expect(page).to have_content('This is the first comment for the first post')
    end

    it 'shows the number of likes' do
      post = Post.first
      expect(page).to have_content(post.likes_counter)
    end

    it "can see the post's body" do
      expect(page).to have_content('This is the first comment')
    end

    it 'username of the comment works' do
      post = Post.first
      comment = post.comments.first
      expect(page).to have_content(comment.user.name)
    end
  end
end
