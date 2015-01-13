class LineupEntryEntity < Grape::Entity
        
  expose :id
  expose :categories

  expose :age
  expose :recommended_age
  expose :duration_min
  expose :num_breaks

  expose :created_at
  expose :updated_at

end
