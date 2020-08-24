require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'is valid with a content' do
    user1 = User.create!(name: 'user1', email: 'user1@mail.com', password: 'password')
    user2 = User.create!(name: 'user2', email: 'user2@mail.com', password: 'password')

    post = user1.posts.create!(content: 'test')

    comment = post.comments.create!(content: 'test', user_id: user2.id)

    expect(comment).to be_valid
  end
  it 'belongs to a user' do
    comment = Comment.reflect_on_association(:user)
    expect(comment.macro).to eq(:belongs_to)
  end

  it 'belongs to a post' do
    comment = Comment.reflect_on_association(:post)
    expect(comment.macro).to eq(:belongs_to)
  end
end
