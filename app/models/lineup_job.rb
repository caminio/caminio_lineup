class LineupJob
  
  include Mongoid::Document
  include Caminio::Timestamps
  include Caminio::Userstamps

  field :title, type: String, localize: true
  field :description, type: String, localize: true
  
  belongs_to :lineup_person
  embedded_in :lineup_entry
  embedded_in :lineup_festival

end
