class User < ActiveRecord::Base

  has_one :kringle
  has_one :wishlist

  #find the user in the database, first by the facebook user id and if that fails through the email hash
  def self.find_by_fb_user(fb_user)
    User.find_by_fb_id(fb_user.uid) || User.find_by_email_hash(fb_user.email_hashes)
  end

  #Take the data returned from facebook and create a new user from it.
  #We don't get the email from Facebook and because a facebooker can only login through Connect we just generate a unique login name for them.
  #If you were using username to display to people you might want to get them to select one after registering through Facebook Connect
  def self.create_from_fb_connect(fb_user)
    new_facebooker = User.new(:username => "fb_#{fb_user.uid}")
    new_facebooker.fb_id = fb_user.uid.to_i

    #We need to save without validations
    new_facebooker.save

    new_facebooker
  end

  #We are going to connect this user object with a facebook id. But only ever one account.
  def link_fb_connect(fb_id)
    unless fb_id.nil?
      #check for existing account
      existing_fb_user = User.find_by_fb_id(fb_id)

      #unlink the existing account
      unless existing_fb_user.nil?
        existing_fb_user.fb_id = nil
        existing_fb_user.save
      end

      #link the new one
      self.fb_id = fb_id
      save
    end
  end

  def facebook_user?
    return !fb_id.nil? && fb_id > 0
  end

end
