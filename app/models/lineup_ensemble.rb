class LineupEnsemble

  include Mongoid::Document
  include Caminio::Timestamps
  include Caminio::Userstamps
  include Caminio::AccessRules
  include LineupAttributes

  field :title, type: String, localize: true
  field :description, type: String, localize: true

  has_and_belongs_to_many :lineup_persons
  has_and_belongs_to_many :lineup_entries
  
  belongs_to :location

end
