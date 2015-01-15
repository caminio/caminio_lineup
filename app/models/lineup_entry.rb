class LineupEntry

  include Mongoid::Document
  include Caminio::Timestamps
  include Caminio::Userstamps

  field :categories, type: Array, default: []

  field :recommended_age, type: Integer, default: 0
  field :age, type: Integer, default: 0
  field :duration_min, type: Integer, default: 60
  field :num_breaks, type: Integer, default: 0

  embeds_many :jobs, class_name: "LineupJob"
  embeds_many :events, class_name: "LineupEvent"
  has_and_belongs_to_many :lineup_ensembles

  index "events.starts" => 1

end
