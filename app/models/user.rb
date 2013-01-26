class User
  include Mongoid::Document

  field :email, type: String

  validates_presence_of :email

  devise :omniauthable

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    User.find_or_create_by email: data["email"]
  end
end

