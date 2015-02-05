class LineupVenue < Location
  
  include LineupAttributes

  field :reach_by_bus, type: String
  field :reach_by_tram, type: String
  field :reach_by_train, type: String
  field :opening_hours, type: String
  
end
