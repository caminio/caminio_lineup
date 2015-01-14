class LineupEnsemble

  include Mongoid::Document
  include LineupAttributes

  field :title, type: String, localize: true
  field :description, type: String, localize: true

  has_many :members, class_name: "LineupPerson"
  belongs_to :location

end
