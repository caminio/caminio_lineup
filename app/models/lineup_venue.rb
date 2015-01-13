class LineupVenue
  
  include Mongoid::Document
  include Caminio::Timestamps
  include Caminio::Userstamps
  include LineupAttributes

  field :reach_by_bus, type: String
  field :reach_by_tram, type: String
  field :reach_by_train, type: String

  field :opening_hours, type: String
  
  belongs_to :location

  # todo map location
end
