class LineupEnsemble

  include Mongoid::Document
  include Caminio::Timestamps
  include Caminio::Userstamps
  include LineupAttributes

  field :title, type: String, localize: true
  field :description, type: String, localize: true

  has_and_belongs_to_many  :members, class_name: "LineupPerson"
  has_and_belongs_to_many  :entries, class_name: "LineupEntry"
  
  belongs_to :location

end
