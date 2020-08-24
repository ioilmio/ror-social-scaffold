require 'rails_helper'

RSpec.describe Friendship, type: :model do
  it 'belongs to a user' do
    friendship = Friendship.reflect_on_association(:user)
    expect(friendship.macro).to eq(:belongs_to)
  end
end
