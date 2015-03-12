class PressQuotes
  
  include Mongoid::Document
  include Caminio::Timestamps
  include Caminio::Userstamps
  include Caminio::AccessRules
  
  field :title, type: String
  field :description, type: String
  field :author, type: String
  field :date_of_appearance, type: Date
  field :media_name, type: String
  field :media_type, type: String, default: "print"

end
