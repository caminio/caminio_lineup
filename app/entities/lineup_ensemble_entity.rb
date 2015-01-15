class LineupEnsembleEntity < Grape::Entity
        
  expose :id

  expose :title
  expose :description

  expose :lineup_entry_ids
  expose :lineup_person_ids

  expose :created_at
  expose :updated_at

end
