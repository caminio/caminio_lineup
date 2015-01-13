class LineupVenueEntity < Grape::Entity
        
  expose :id

  expose :reach_by_bus
  expose :reach_by_tram
  expose :reach_by_train
  expose :opening_hours

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

  expose :created_at
  expose :updated_at

end