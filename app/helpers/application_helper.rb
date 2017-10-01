module ApplicationHelper
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'http://www.timepassfun.com/wp-content/uploads/2011/12/avatar-celebrities-13.jpg'
    end
  end
end
