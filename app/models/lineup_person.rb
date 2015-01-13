class LineupPerson
  
  include Mongoid::Document

  field :firstname, type: String
  field :midname, type: String
  field :lastname, type: String
  field :email, type: String
  field :phone, type: String
  field :position, type: Integer

  has_one :location
  embeds_one :lineup_attributes
  
end