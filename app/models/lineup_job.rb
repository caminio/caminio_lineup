class LineupJob
  
  include Mongoid::Document
  include Caminio::Timestamps
  include Caminio::Userstamps

  field :title, type: String
  field :description, type: String
  
  belongs_to :lineup_person

end
