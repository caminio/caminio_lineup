class LineupFestival
  
  include Mongoid::Document
  include Caminio::Timestamps
  include Caminio::Userstamps
  include LineupAttributes

  field :title, type: String, localize: true
  field :description, type: String, localize: true

  has_many :jobs, class_name: "LineupJob"
  has_many :events, class_name: "LineupEvent"
  has_many :entrys, class_name: "LineupEntry"

end
