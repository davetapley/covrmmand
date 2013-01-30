class Credential
  include Mongoid::Document

  field :token, type: String
  field :refresh_token, type: String
  field :expires_at, type: Time
  field :expires, type: Boolean

  embedded_in :user

end

