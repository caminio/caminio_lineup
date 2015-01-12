class LineupEntryEntity < Grape::Entity
        
  root :lineup_entries, :lineup_entry

  expose :created_at
  expose :updated_at

end
