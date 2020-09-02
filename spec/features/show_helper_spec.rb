require 'rails_helper'

RSpec.describe 'User', type: :feature do
  scenario 'want to unfriend' do
    visit new_user_registration_path
    fill_in 'Name', with: 'Emmanuel'
    fill_in 'Email', with: 'emmanuel@gmail.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_on 'Sign up'
    click_on 'Sign out'
    visit new_user_registration_path
    fill_in 'Name', with: 'Salvatore'
    fill_in 'Email', with: 'salva@gmail.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_on 'Sign up'
    visit users_path
    click_link 'Send Request'
    click_on 'Sign out'
    fill_in 'Email', with: 'emmanuel@gmail.com'
    fill_in 'Password', with: 'password'
    click_on 'Log in'
    click_link 'Friend requests'
    click_link 'Accept'
    click_on 'Sign out'
    fill_in 'Email', with: 'salva@gmail.com'
    fill_in 'Password', with: 'password'
    click_on 'Log in'
    visit users_path
    user = User.first
    visit "users/#{user.id}"
    expect(page).to have_content('Unfriend')
  end
  scenario 'want to send request' do
    visit new_user_registration_path
    fill_in 'Name', with: 'Emmanuel'
    fill_in 'Email', with: 'emmanuel@gmail.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_on 'Sign up'
    click_on 'Sign out'
    visit new_user_registration_path
    fill_in 'Name', with: 'Salvatore'
    fill_in 'Email', with: 'salva@gmail.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_on 'Sign up'
    user = User.find_by(name: 'Emmanuel')
    visit "users/#{user.id}"
    expect(page).to have_link('Send Request')
  end
end
