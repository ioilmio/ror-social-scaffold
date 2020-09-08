require 'rails_helper'

RSpec.describe 'User', type: :feature do
  scenario 'with pending friends' do
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
    user = User.first
    visit "/users/#{user.id}/pending_friends"
    expect(page).to have_content('Emmanuel')
  end

  scenario 'with friend request' do
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
    user = User.first
    visit "/users/#{user.id}/pending_friends"
    expect(page).to have_content('Emmanuel')
  end
  scenario 'confirm friendships' do
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
    user = User.second
    visit "/users/#{user.id}/friend_requests"
    expect(page).to have_content('Salvatore')
  end
end
