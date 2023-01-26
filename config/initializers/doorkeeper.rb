Doorkeeper.configure do
  orm :active_record

  grant_flows ["client_credentials"]
  default_scopes :read, :write
  enforce_configured_scopes
  allow_blank_redirect_uri true
end
