require 'rails_helper'

RSpec.describe 'Login', type: :feature do
  describe 'tests' do
    before(:each) do
      User.create(name: 'orcun', password: '123456', bio: 'Test User', email: 'test@test.com',
                  confirmed_at: Time.now)
    end

    it 'Renders Right Page' do
      visit new_user_session_path
      expect(page).to have_content('Log in')
    end

    it 'Fill email and password inputs' do
      visit new_user_session_path
      fill_in 'Email', with: 'invalid@test.com'
      fill_in 'Password', with: '12356'
      click_button 'Log in'
      expect(page).to have_content('Invalid Email or password.')
    end

    it 'Without fill email and password inputs' do
      visit new_user_session_path
      fill_in 'Email', with: ''
      fill_in 'Password', with: ''
      click_button 'Log in'
      expect(page).to have_content('Invalid Email or password.')
    end

    it 'Fill email and password inputs' do
      visit new_user_session_path
      fill_in 'Email', with: 'test@test.com'
      fill_in 'Password', with: '123456'
      click_button 'Log in'
      expect(page).to have_content('Signed in successfully.')
      expect(page).to have_current_path root_path
    end
  end
end
