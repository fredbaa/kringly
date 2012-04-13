class UsersController < ApplicationController
  layout 'main'

  def link_user_accounts
    user = User.find_by_fb_user(facebook_session.user)
    if user.nil?
      user = User.create_from_fb_connect(facebook_session.user)
    end

    session[:user] = user
    current_user.link_fb_connect(facebook_session.user.id) unless current_user.fb_id == facebook_session.user.id

    redirect_to root_path
  end

end
