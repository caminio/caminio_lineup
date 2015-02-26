module LineupAttributes

  extend ActiveSupport::Concern

  included do

    field :tags, type: Array, default: []

    field :ext_ref_id, type: String
    field :ext_ref_src, type: String
    field :ext_ref_note, type: String
    field :ext_ref_sync_at, type: String

    field :orig_url, type: String
    field :ext_url, type: String
    field :video_url, type: String
    field :video_type, type: String

    field :others_write, type: Boolean, default: true
    field :notify_me_on_write, type: Boolean, default: true

  end
end
