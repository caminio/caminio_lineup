class LineupJob
  
  include Mongoid::Document

  field :title, type: String
  has_one :lineup_person

end
