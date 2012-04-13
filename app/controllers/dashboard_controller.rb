class DashboardController < ApplicationController
  layout "main"

  def home
    @all_users = User.all
  end

  def replace_content
    render :partial => "dashboard/#{params[:content]}"
  end

  def randomize
    if current_user.kringle.nil?
      kringle = get_random_kringle
    else
      kringle = current_user.kringle
    end

    render :partial => "dashboard/lucky_person", :locals => {:kringle => kringle}
  end

  def save_wish
    wishlist = Wishlist.find_by_user_id(current_user.id) ||
               Wishlist.new(:user_id => current_user.id)
    wishlist.wish = params["wishlist"]["wish"]
    wishlist.save
  end

  private

  def get_random_kringle
    user = current_user
    nabunutan = Kringle.all.map(&:manito_id) + [user.id]

    users = User.find(:all, :conditions => ["id NOT IN (?)", nabunutan])
    idx = rand(users.size)

    manito = users[idx]

    kringle = Kringle.create(:user => user, :manito => manito)

    kringle
  end
end
