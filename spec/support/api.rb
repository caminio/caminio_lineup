module Caminio
  module API

    class Root < Grape::API
      
      mount Caminio::V1::LineupEntries    => '/v1/lineup_entries'
      mount Caminio::V1::LineupVenues     => '/v1/lineup_venues'
      mount Caminio::V1::LineupPersons    => '/v1/lineup_persons'
      mount Caminio::V1::LineupJobs       => '/v1/lineup_jobs'

    end

  end
end
