# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_train_session',
  :secret      => '1b84f3e115abafbf6c71e591620ba642dd8dea5ac396b43d33a4e5a03b9a961da6431a9e6ab0da65de294665eb5e59794818b6599fe3b222b3a496625a4c947f'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
