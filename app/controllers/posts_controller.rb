class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @post = Post.new
    timeline_posts
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

  def timeline_posts
    friends_posts = []
    user_posts = Post.where(user: current_user)
    friends = current_user.friends
    friends.each do |friend|
      friends_posts += Post.where(user: friend)
    end
    posts = user_posts + friends_posts

    @timeline_posts = posts
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
