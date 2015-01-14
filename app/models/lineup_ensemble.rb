class LineupEnsemble

  include Mongoid::Document
  include Caminio::Timestamps
  include Caminio::Userstamps
  include LineupAttributes

  field :title, type: String, localize: true
  field :description, type: String, localize: true

  embeds_many :members, class_name: "LineupPerson"
  belongs_to :location

end
