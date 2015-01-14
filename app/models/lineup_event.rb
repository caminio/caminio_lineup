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

  belongs_to :lineup_venue

end
