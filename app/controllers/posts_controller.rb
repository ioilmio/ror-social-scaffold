class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @post = Post.new
    # timeline_posts
    current_user.friends_and_own_posts
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to posts_path, notice: 'Post was successfully created.'
    else
      timeline_posts
      render :index, alert: 'Post was not created.'
    end
  end

  private

  # def timeline_posts
  #   friends_posts = []
  #   user_posts = current_user.posts
  #   friends = current_user.friends
  #   friends.each do |friend|
  #     friends_posts += friend.posts
  #   end
  #   posts = user_posts + friends_posts

  #   @timeline_posts = posts
  # end

  def post_params
    params.require(:post).permit(:content)
  end
end
