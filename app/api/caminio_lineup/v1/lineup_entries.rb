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

      #
      # POST /
      #
      desc "create a new lineup_entry"
      params do
        requires :lineup_entry, type: Hash do
          optional :categories
        end
      end
      post do
        authenticate!
        entry = LineupEntry.new( declared( params )[:lineup_entry] )
        error!({ error: 'SavingFailed', details: entry.errors.full_messages}, 422) unless entry.save
        present :lineup_entry, entry, with: LineupEntryEntity
      end

      #
      # PUT /:id
      #
      desc "update an existing lineup_entry"
      params do
        requires :lineup_entry, type: Hash do
          optional :categories
        end
      end
      put '/:id' do
        authenticate!
        entry = LineupEntry.find params.id 
        error! "LineupEntryNotFound", 404 unless entry
        entry.update_attributes( declared(params)[:lineup_entry] )
        present :lineup_entry, entry.reload, with: LineupEntryEntity
      end

      #
      # DELETE /:id
      #
      desc "delete an lineup_entry"
      formatter :json, lambda{ |o,env| "{}" }
      delete '/:id' do
        authenticate!
        entry = LineupEntry.find params.id 
        error! "LineupEntryNotFound", 404 unless entry
        error!("DeletionFailed",500) unless entry.destroy
      end

    end
  end
end