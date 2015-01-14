Rails.application.routes.draw do

  mount Caminio::V1::LineupEntries    => "/api/v1/lineup_entries"
  mount Caminio::V1::LineupVenues     => "/api/v1/lineup_venues"
  mount Caminio::V1::LineupPersons    => "/api/v1/lineup_persons"
  mount Caminio::V1::LineupJobs       => "/api/v1/lineup_jobs"
  mount Caminio::V1::LineupEnsembles       => "/api/v1/lineup_ensembles"

end
