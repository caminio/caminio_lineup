class LineupEventEntity < Grape::Entity
        
  expose :id

  expose :starts
  expose :note
  expose :book_phone
  expose :book_email
  expose :book_url
  expose :concessions
  expose :premiere
  expose :derniere
  expose :cancelled
  
  expose :lineup_venue_id
  
  expose :created_at
  expose :updated_at

end
