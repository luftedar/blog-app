require 'rails_helper'

RSpec.describe 'User Index', type: :feature do
  describe 'User' do
    before(:each) do
      @user1 = User.create(name: 'first', password: '123456', bio: 'I am the first user',
                           email: 'first@first.com', confirmed_at: Time.now)
      @user2 = User.create(name: 'second', password: '123456', bio: 'I am the second user',
                           email: 'second@second.com', confirmed_at: Time.now)
      @user3 = User.create(name: 'third', password: '123456', bio: 'I am the third user',
                           email: 'third@third.com', confirmed_at: Time.now)
      visit root_path
      fill_in 'Email', with: 'first@first.com'
      fill_in 'Password', with: '123456'
      click_button 'Log in'
      visit root_path
    end

    it 'renders the user names' do
      expect(page).to have_content('first')
      expect(page).to have_content('second')
      expect(page).to have_content('third')
    end

    it 'shows the photo' do
      image = page.all('img')
      expect(image.size).to eql(3)
    end

    it 'shows the number of posts' do
      expect(page).to have_content('Number of')
    end

    it 'show users page' do
      click_on 'first'
      expect(page).to have_current_path user_path(@user1)
      expect(page).to have_content('first')
    end
  end
end
