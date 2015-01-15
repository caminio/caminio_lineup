class LineupPerson
  
  include Mongoid::Document
  include Caminio::Timestamps
  include Caminio::Userstamps
  include LineupAttributes

  field :firstname, type: String
  field :midname, type: String
  field :lastname, type: String
  field :email, type: String
  field :phone, type: String
  field :position, type: Integer, localize: true

  has_and_belongs_to_many :ensembles, class_name: "LineupEnsemble"
  belongs_to :location
  
end