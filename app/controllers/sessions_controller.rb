class SessionsController < ApplicationController
  layout 'main'

  def sign_out
    session[:user] = nil

    redirect_to root_path
  end
end
