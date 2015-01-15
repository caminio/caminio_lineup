class LineupJobEntity < Grape::Entity
        
  expose :id
  
  expose :title
  expose :description
  
  expose :lineup_person_id

  expose :created_at
  expose :updated_at

end
