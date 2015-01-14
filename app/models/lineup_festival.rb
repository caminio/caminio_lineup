class LineupFestival
  
  include Mongoid::Document
  include Caminio::Timestamps
  include Caminio::Userstamps

  field :title, type: String, localize: true
  field :description, type: String, localize: true

  has_many :jobs, class: "LineupJob"
  has_many :events, class: "LineupEvent"
  has_many :entrys, class: "LineupEntry"

end
