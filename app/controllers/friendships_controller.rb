class FriendshipsController < ApplicationController
  def index
    @friendships = Friendship.all
  end

  def create
    @friendship = Friendship.new(friendship_params)
    return unless @friendship.save

    redirect_to request.referrer, notice: "Your friendship request to #{@friendship.friend.name} has been sent"
  end

  def confirm
    @user = User.find(params[:friendship_id])
    current_user.confirm_friend(@user)
    flash[:notice] = "You are now friend with #{@user.name} "
    redirect_to request.referrer
  end

  def reject
    @friendship = Friendship.find_by(friendship_params[:user_id], friendship_params[:friend_id])
    flash[:alert] = "I don't want to be your friend, #{@friendship.user.name}, sorry" if @friendship.destroy
    redirect_to request.referrer
  end

  def destroy
    @user = User.find(params[:id])
    current_user.unfriend(@user, current_user)
    flash[:alert] = "You are no longer friend with #{@user.name}"
    redirect_to request.referrer
  end

  private

  def friendship_params
    params.permit(:user_id, :friend_id)
  end
end
