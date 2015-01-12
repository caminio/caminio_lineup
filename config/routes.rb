Rails.application.routes.draw do

  mount Caminio::V1::LineupEntries => "/api/v1/lineup_entries"

end
