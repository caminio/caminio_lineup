class LineupVenue
  
  include Mongoid::Document
  include Caminio::Timestamps
  include Caminio::Userstamps

  field :tag, type: Array, default: []

  field :reach_by_bus, type: String
  field :reach_by_tram, type: String
  field :reach_by_train, type: String

  field :opening_hours, type: String

  embeds_one :lineup_attributes
  
  has_one :location

  # todo map location
end
