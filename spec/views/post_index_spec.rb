require 'rails_helper'

RSpec.describe 'Login', type: :feature do
  describe 'User' do
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

      visit user_posts_path(@user1)
    end

    it 'shows user photo' do
      image = page.all('img')
      expect(image.size).to eql(1)
    end

    it 'shows the username' do
      expect(page).to have_content('first')
    end

    it "Post's length" do
      post = Post.all
      expect(post.size).to eql(3)
    end

    it 'shows number of posts by user' do
      user = User.first
      expect(page).to have_content(user.posts_counter)
    end

    it 'shows post title' do
      expect(page).to have_content('Second Post')
      visit user_session_path
    end

    it "can see some of the post's body." do
      expect(page).to have_content 'This is the first post'
    end

    it 'can see the first comments on a post' do
      expect(page).to have_content 'This is the first comment for the first post'
    end

    it 'can see how many comments a post has.' do
      post = Post.first
      expect(page).to have_content(post.comments_counter)
    end

    it 'can see how many likes a post has.' do
      post = Post.first
      expect(page).to have_content(post.likes_counter)
    end

    it "When I click on a post, it redirects me to that post's show page." do
      expect(page).to have_content 'This is the third post'
    end
  end
end