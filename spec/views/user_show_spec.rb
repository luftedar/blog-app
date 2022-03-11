require 'rails_helper'
RSpec.describe 'user_show', type: :feature do
  describe 'User & Post' do
    before(:each) do
      @user1 = User.create(name: 'first', password: '123456',
                           bio: 'I am the first user',
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
      visit user_path(@user1.id)
    end
    it 'shows the profile photo' do
      image = page.all('img')
      expect(image.size).to eql(1)
    end
    it 'shows the username' do
      expect(page).to have_content('first')
    end
    it 'shows the number of posts' do
      expect(page).to have_content('Number of')
    end
    it 'shows the users bio' do
      expect(page).to have_content('I am the first user')
    end
    it 'renders the button' do
      expect(page).to have_content('See all posts')
    end
    it 'redirect to see all posts' do
      click_link 'See all posts'
      expect(page).to have_current_path user_posts_path(@user1)
    end
    it 'renders first 3 posts' do
      expect(page).to have_content 'This is the first post'
      expect(page).to have_content 'This is the second post'
      expect(page).to have_content 'This is the third post'
    end
  end
end
