class User
  include Mongoid::Document

  field :email, type: String
  field :name, type: String
  field :active, type: Boolean
  field :level, type: Integer

  embeds_one :credential
  embeds_one :location

  attr_accessible :email, :name, :active, :level

  validates_presence_of :email
  validates :level, inclusion: { in: 1..8, allow_nil: true }

  devise :omniauthable

  acts_as_gmappable process_geocoding: false
  delegate :latitude, to: :location
  delegate :longitude, to: :location

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    user = User.find_or_create_by email: access_token.info.email
    credentials = access_token.credentials
    user.create_credential token: credentials.token, expires_at: Time.at(credentials.expires_at), expires: credentials.expires
    user
  end

  def update_location!
    client = Google::APIClient.new
    client.authorization.access_token = credential.token

    latitude = client.discovered_api('latitude')
    result = client.execute api_method: latitude.current_location.get, parameters: { 'granularity' => 'best' }

    unless result.success?
      puts "Update for #{ email } failed"
      return
    end

    data = MultiJson.load(result.body)['data']
    create_location timestamp: Time.at(data['timestampMs'].to_i), latitude: data['latitude'], longitude: data['longitude'], accuracy: data['accuracy']
  end

end

