class LineupEntryEntity < Grape::Entity

  expose :lineup_event_ids do |entry|
    entry.events.map do |event|
      event.id
    end
  end

  expose :lineup_job_ids do |entry|
    entry.jobs.map do |event|
      event.id
    end
  end

  expose :mediafile_ids do |entry|
    entry.mediafiles.map do |mf|
      mf.id
    end
  end
  
  expose :lineup_ensemble_ids
        
  expose :id
  expose :categories

  expose :age
  expose :recommended_age
  expose :duration_min
  expose :num_breaks

  expose :created_at
  expose :updated_at

end
