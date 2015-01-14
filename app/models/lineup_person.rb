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

  belongs_to :location
  
end