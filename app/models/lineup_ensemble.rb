class LineupEnsemble

  include Mongoid::Document
  include LineupAttributes

  has_many :members, class_name: "LineupPerson"
  belongs_to :location

end
