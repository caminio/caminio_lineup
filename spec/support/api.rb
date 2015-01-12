module Caminio
  module API

    class Root < Grape::API
      
      mount Caminio::V1::LineupEntries => '/v1/lineup_entries'

    end

  end
end
