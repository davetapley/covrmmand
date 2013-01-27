class Location
  include Mongoid::Document

  field :timestamp, type: Time
  field :latitude, type: Float
  field :longitude, type: Float
  field :accuracy, type: Integer

  embedded_in :user

end

