class LineupFestival
  
  include Mongoid::Document
  include Caminio::Timestamps
  include Caminio::Userstamps
  include LineupAttributes

  field :title, type: String, localize: true
  field :description, type: String, localize: true

  embeds_many :jobs, class_name: "LineupJob"
  embeds_many :events, class_name: "LineupEvent"
  has_and_belongs_to_many :entries, class_name: "LineupEntry"

  index "events.starts" => 1

end
