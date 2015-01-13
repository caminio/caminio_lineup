class LineupEntryEntity < Grape::Entity
        
  root :lineup_entries, :lineup_entry

  expose :id
  expose :categories
  expose :created_at
  expose :updated_at

end
