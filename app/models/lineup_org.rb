class LineupOrg
  
  include Mongoid::Document
  include Caminio::Timestamps
  include Caminio::Userstamps

  field :type, type: String
  field :tag, type: Array, default: []

  # TODO location?

  field :ext_ref_id, type: String
  field :ext_ref_src, type: String
  field :ext_ref_note, type: String
  field :ext_ref_sync_at, type: String

  field :orig_url, type: String
  field :ext_url, type: String
  field :video_url, type: String
  field :video_type, type: String

  field :others_write, type: String
  field :notify_me_on_write, type: Boolean, default: true

  field :reach_by_bus, type: String
  field :reach_by_tram, type: String
  field :reach_by_train, type: String

  field :openingHours, type: String

  field :email, type: String
  field :phone, type: String

end
