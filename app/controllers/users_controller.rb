class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    @mutual_friends = current_user.mutual_friends(@user, current_user)
  end

  def pending_friends
    @users = current_user.pending_friends
  end

  def friend_requests
    @users = current_user.friend_requests
  end
end
