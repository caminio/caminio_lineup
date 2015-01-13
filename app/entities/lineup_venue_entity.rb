class LineupVenueEntity < Grape::Entity
        
  expose :id

  expose :reach_by_bus
  expose :reach_by_tram
  expose :reach_by_train
  expose :opening_hours

  expose :created_at
  expose :updated_at

end