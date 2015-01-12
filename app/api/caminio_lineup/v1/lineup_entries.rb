module Caminio

  module V1

    class LineupEntries < Grape::API

      default_format :json

      #
      # GET /
      #
      desc "lists all users"
      get do
        lineup_entries = LineupEntry.all
        present lineup_entries, with: LineupEntryEntity
      end

    end
  end
end