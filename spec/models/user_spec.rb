require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user_param1) do
    {
      name: 'user1',
      email: 'user1@mail.com',
      password: 'password'
    }
  end
  let(:user_param2) do
    {
      name: 'user2',
      email: 'user2@mail.com',
      password: 'password'
    }
  end

  context 'Association tests' do
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
      user1 = User.create(user_param1)
      user2 = User.create(user_param2)
      user1.friendships.create(user_id: user1.id, friend_id: user2.id, confirmed: true)
      expect(user1.friendships.count).to eq(1)
    end
    it 'shouldnt have friends' do
      user1 = User.create(user_param1)
      expect(user1.friendships.count).to eq(0)
    end
  end

  context 'Friendships' do
    it 'should return friends' do
      user = User.create(user_param1)
      friend = User.create(user_param2)
      user.friendships.create(user_id: user.id, friend_id: friend.id, confirmed: true)
      expect(user.friends.empty?).to be false
    end

    it 'should return pending friends' do
      user = User.create(user_param1)
      friend = User.create(user_param2)
      user.friendships.create(user_id: user.id, friend_id: friend.id, confirmed: nil)
      expect(user.pending_friends.empty?).to be false
    end

    it 'should return friend requests' do
      user = User.create(user_param1)
      friend = User.create(user_param2)
      user.friendships.create(user_id: user.id, friend_id: friend.id, confirmed: nil)
      expect(friend.friend_requests.empty?).to be false
    end

    it 'should confirm a friendship' do
      user = User.create(user_param1)
      friend = User.create(user_param2)
      user.friendships.create(user_id: user.id, friend_id: friend.id, confirmed: nil)
      expect(friend.confirm_friend(user)).to be true
    end

    it 'should check whether friends' do
      user = User.create(user_param1)
      friend = User.create(user_param2)
      user.friendships.create(user_id: user.id, friend_id: friend.id, confirmed: true)
      expect(user.friend?(friend)).to be true
    end
  end
end
