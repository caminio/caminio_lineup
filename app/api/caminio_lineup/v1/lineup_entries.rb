module Caminio

  module V1

    class LineupEntries < Grape::API

      default_format :json
      helpers Caminio::AuthHelper

      #
      # GET /
      #
      desc "lists all lineup_entries"
      get do
        lineup_entries = LineupEntry.all
        present :lineup_entries, lineup_entries, with: LineupEntryEntity
      end

      #
      # GET /:id
      #
      desc "returns lineup_entry with :id"
      get ':id' do
        authenticate!
        entry = LineupEntry.where(id: params.id).first
        error!('NotFound',404) unless entry
        present :lineup_entry, entry, with: LineupEntryEntity
      end


    end
  end
end