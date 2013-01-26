class User
  include Mongoid::Document

  field :email, type: String
  field :name, type: String
  field :active, type: Boolean
  field :level, type: Integer

  attr_accessible :email, :name, :active, :level

  validates_presence_of :email
  validates :level, inclusion: { in: 1..8, allow_nil: true }

  devise :omniauthable

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    User.find_or_create_by email: data["email"]
  end
end

