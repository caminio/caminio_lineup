class LineupEntry

  include Mongoid::Document
  include Caminio::Timestamps
  include Caminio::Userstamps
  include Caminio::AccessRules
  include LineupAttributes

  field :title, localize: true
  field :subtitle, localize: true
  field :description, localize: true
  field :categories, type: Array, default: []

  field :recommended_age, type: Integer, default: 0
  field :age, type: Integer, default: 0
  field :duration_min, type: Integer, default: 60
  field :num_breaks, type: Integer, default: 0

  has_many :mediafiles, as: :parent
  embeds_many :jobs, class_name: "LineupJob"
  embeds_many :events, class_name: "LineupEvent"
  embeds_many :quotes, class_name: "PressQuote"
  has_and_belongs_to_many :lineup_ensembles

  index "events.starts" => 1

end
