module Caminio
  module API

    class Root < Grape::API
      
      mount Caminio::V1::LineupEntries => '/v1/lineup_entries'
      mount Caminio::V1::LineupVenues => '/v1/lineup_venues'

    end

  end
end
