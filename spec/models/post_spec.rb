require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'is valid with a content' do
    user1 = User.create(name: 'user1', email: 'user1@mail.com', password: 'password')

    post = user1.posts.create!(content: 'test')
    expect(post).to be_valid
  end
  it 'belongs to a user' do
    post = Post.reflect_on_association(:user)
    expect(post.macro).to eq(:belongs_to)
  end
end
