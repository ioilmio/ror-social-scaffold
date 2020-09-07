require 'rails_helper'

RSpec.describe Post, type: :feature do
  describe 'create a posts', js: true do
    it 'on index page' do
      visit new_user_registration_path
      fill_in 'Name', with: 'user1'
      fill_in 'Email', with: 'user1@mail.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      click_on 'Sign up'
      fill_in 'post[content]', with: 'test'
      click_on 'Save'
      expect(page).to have_content('test')
    end
  end
end
