module UserHelper
  def current_user_friendships(user)
    if current_user.friend?(user) && user != current_user
      link_to '<button type="button">Unfriend</button>'.html_safe,
              friendship_path(user.id), method: :delete, data: { confirm: 'Are you sure you want to Unfriend' }
    elsif current_user.pending_friends.include?(user)
      link_to "Request pending #{user.name}", user_path(user), class: 'profile-link'
    elsif current_user.friend_requests.include?(user)
      link_to '<button type="button">Reject</button>'.html_safe,
              friendship_reject_path(user), method: :delete
    elsif user != current_user
      link_to '<button type="button">Send Request</button>'.html_safe,
              friendships_path(user_id: current_user.id, friend_id: user.id),
              method: :post
    end
  end

  def requests_buttons(user)
    return unless current_user.friend_requests.include?(user)

    link_to '<button type="button">Accept</button>'.html_safe,
            friendship_confirm_path(user), method: :post
  end
end
