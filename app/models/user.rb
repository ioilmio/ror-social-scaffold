class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :friendships, dependent: :destroy
  has_many :pending_friendships, -> { where confirmed: nil }, class_name: 'Friendship', foreign_key: 'user_id'
  has_many :pending_friends, through: :pending_friendships, source: :friend

  has_many :inverted_friendships, -> { where confirmed: nil }, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :friend_requests, through: :inverted_friendships, source: :user

  has_many :confirmed_friend, -> { where confirmed: true }, class_name: 'Friendship'
  has_many :friends, through: :confirmed_friend

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def confirm_friend(user)
    friendship = inverted_friendships.find { |friend| friend.user == user }
    friendship.confirmed = true
    friendship.save
  end

  def mutual_friends(friend, current_user)
    my_users = User.all
    current_user_friends = []
    user_friends = []
    mutual_friendship = []
    my_users.each do |user|
      current_user_friends.push(user) if current_user.friend?(user)
      user_friends.push(user) if friend.friend?(user)
    end
    current_user_friends.each do |user|
      mutual_friendship.push(user) if user_friends.include?(user)
    end
    user_friends.each do |user|
      mutual_friendship.push(user) if current_user_friends.include?(user) && !mutual_friendship.include?(user)
    end
    mutual_friendship
  end

  def friend?(user)
    friends.include?(user)
  end
end
