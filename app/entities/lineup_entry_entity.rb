class LineupEntryEntity < Grape::Entity

  expose :lineup_event_ids do |entry|
    entry.events.map do |event|
      event.id
    end
  end
        
  expose :id
  expose :categories

  expose :age
  expose :recommended_age
  expose :duration_min
  expose :num_breaks

  expose :created_at
  expose :updated_at

end
