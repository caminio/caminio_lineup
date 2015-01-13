class LineupEntry

  include Mongoid::Document
  include Caminio::Timestamps
  include Caminio::Userstamps

  field :categories, type: Array, default: []

  field :recommended_age, type: Integer, default: 0
  field :age, type: Integer, default: 0
  field :duration_min, type: Integer, default: 60
  field :num_breaks, type: Integer, default: 0

  embeds_one :lineup_attributes
  embeds_many :lineup_jobs
  embeds_many :lineup_venues
  embeds_many :lineup_ensembles
  embeds_many :lineup_events
end
