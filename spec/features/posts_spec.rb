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
    it 'on index page and is not valid' do
      visit new_user_registration_path
      fill_in 'Name', with: 'user1'
      fill_in 'Email', with: 'user1@mail.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      click_on 'Sign up'
      fill_in 'post[content]', with: ''
      click_on 'Save'
      expect(page).to have_content("Post could not be saved. Content can't be blank")
    end
  end
  describe 'display buttons', js: true do
    it 'under the post for like button' do
      visit new_user_registration_path
      fill_in 'Name', with: 'user1'
      fill_in 'Email', with: 'user1@mail.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      click_on 'Sign up'
      fill_in 'post[content]', with: 'test'
      click_on 'Save'
      expect(page).to have_link('Like!')
    end
    it 'under the post for like button' do
      visit new_user_registration_path
      fill_in 'Name', with: 'user1'
      fill_in 'Email', with: 'user1@mail.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      click_on 'Sign up'
      fill_in 'post[content]', with: 'test'
      click_on 'Save'
      click_link 'Like!'
      expect(page).to have_content('Dislike!')
    end
  end
end
