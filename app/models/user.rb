class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: :friend_id

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def friends
    friends_array = friendships.map { |friendship| friendship.friend if friendship.confirmed }
    friends_array.concat(inverse_friendships.map { |friendship| friendship.user if friendship.confirmed })
    friends_array.compact
  end

  def pending_friends
    friendships.map { |friendship| friendship.friend unless friendship.confirmed }.compact
  end

  def friend_requests
    inverse_friendships.map { |friendship| friendship.user unless friendship.confirmed }.compact
  end

  def confirm_friend(user)
    friendship = inverse_friendships.find { |friend| friend.user == user }
    friendship.confirmed = true
    friendship.save
  end

  def unfriend(user, current_user)
    r = []
    friendship = inverse_friendships.find { |friend| friend.user == user }
    if !friendship.blank?
      friendship.confirmed = nil
      friendship.destroy
    else
      current_user.friends.each do |friend|
        r.push(friend) if friend == user
        my = Friendship.where(user_id: current_user.id, friend_id: r.first.id)
        my.destroy(my.first.id)
      end
    end
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
