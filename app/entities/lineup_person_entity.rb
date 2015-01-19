class LineupPersonEntity < Grape::Entity
        
  expose :id
  
  expose :firstname
  expose :midname
  expose :lastname
  expose :email
  expose :phone
  expose :position

  expose :tags
  expose :ext_ref_id
  expose :ext_ref_src
  expose :ext_ref_note
  expose :ext_ref_sync_at
  expose :orig_url
  expose :ext_url
  expose :video_url
  expose :video_type
  expose :others_write
  expose :notify_me_on_write

  expose :lineup_ensemble_ids
  expose :location_id

  expose :created_at
  expose :updated_at

end
