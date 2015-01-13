class LineupEntry
  
  include Mongoid::Document
  include Caminio::Timestamps
  include Caminio::Userstamps

  field :categories, type: Array, default: []

  field :recommended_age, type: Integer, default: 0
  field :age, type: Integer, default: 0
  field :duration_min, type: Integer, default: 60
  field :num_breaks, type: Integer, default: 0

  field :ext_ref_id, type: String
  field :ext_ref_src, type: String
  field :ext_ref_note, type: String
  field :ext_ref_sync_at, type: String

  field :orig_project_url, type: String
  field :video_id, type: String
  field :video_provider, type: String

  field :others_write, type: String
  field :notify_me_on_write, type: Boolean

end
