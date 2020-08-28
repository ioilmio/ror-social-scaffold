module ShowHelper
  def user_friendship_buttons(user)
    if current_user.friend?(user)
      link_to '<button type="button">Unfriend</button>'.html_safe, friendship_path(user),
              method: :delete, data: { confirm: 'Are you sure you want to Unfriend' }
    elsif current_user != user
      link_to '<button type="button">Send Request</button>'.html_safe,
              friendships_path(user_id: current_user.id, friend_id: user.id),
              method: :post

      link_to 'Timeline', posts_path
    end
  end
end
