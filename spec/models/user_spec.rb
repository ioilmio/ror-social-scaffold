require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has many posts' do
    user = User.reflect_on_association(:posts)
    expect(user.macro).to eq(:has_many)
  end
  it 'has many comments' do
    user = User.reflect_on_association(:comments)
    expect(user.macro).to eq(:has_many)
  end
  it 'has many likes' do
    user = User.reflect_on_association(:likes)
    expect(user.macro).to eq(:has_many)
  end

  it 'should have at least one friend' do
    user1 = User.create(name: 'user1', email: 'user1@mail.com', password: 'password')
    user2 = User.create(name: 'user2', email: 'user2@mail.com', password: 'password')

    user1.friendships.create(user_id: user1.id, friend_id: user2.id, confirmed: true)
    expect(user1.friendships.count).to eq(1)
  end
  it 'shouldnt have friends' do
    user1 = User.create(name: 'user3', email: 'user3@mail.com', password: 'password')
    expect(user1.friendships.count).to eq(0)
  end
end
