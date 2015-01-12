class LineupEntry
  include Mongoid::Document
  include Caminio::Timestamps
  include Caminio::Userstamps
  include ActiveModel::SecurePassword

  field :username, type: String
end
