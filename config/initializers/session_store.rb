# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_bunot_session',
  :secret      => '6694da71bf60316145eaef0755fea966357995840b9141f499e90562ef14f4701a4978f1879953ba9d71a283f26cadbee7c4cf8f76c306a7d8566f1b48fcf433'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
