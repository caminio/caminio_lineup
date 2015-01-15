class LineupEvent
  
  include Mongoid::Document
  include Caminio::Timestamps
  include Caminio::Userstamps

  field :starts, type: Date

  field :note, type: String, localize: true
  field :book_phone, type: String
  field :book_email, type: String
  field :book_url, type: String

  field :concessions, type: Array

  field :premiere, type: Boolean, default: false
  field :derniere, type: Boolean, default: false
  field :cancelled, type: Boolean, default: false

  has_and_belongs_to_many :lineup_ensembles
  belongs_to :lineup_venue
  embedded_in :lineup_entry
  embedded_in :lineup_festival

end
