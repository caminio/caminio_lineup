module Caminio

  module V1

    class LineupEntries < Grape::API

      default_format :json
      helpers Caminio::AuthHelper

      #
      # GET /
      #
      desc "lists all lineup_entries with an event in the future"
      get do
        authenticate_public!
        lineup_entries = LineupEntry.elem_match( events: { starts: { '$gt' => DateTime.now } } )
        events = []
        lineup_entries.each do |entry| 
          entry.events.each { |evt| events.push evt if evt.starts > DateTime.now }
        end
        present :lineup_entries, lineup_entries, with: LineupEntryEntity
        present :lineup_events, events, with: LineupEventEntity
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
        present :lineup_events, entry.events, with: LineupEventEntity
      end

      #
      # POST /
      #
      desc "create a new lineup_entry"
      params do
        requires :lineup_entry, type: Hash do          
          optional :title
          optional :subtitle
          optional :description
          optional :categories
          optional :age
          optional :recommended_age
          optional :duration_min
          optional :num_breaks
          optional :lineup_ensemble_ids
        end
      end
      post do
        authenticate!
        entry = LineupEntry.new( declared( params )[:lineup_entry] )
        error!({ error: 'SavingFailed', details: entry.errors.full_messages}, 422) unless entry.save
        present :lineup_entry, entry, with: LineupEntryEntity
        present :lineup_events, entry.events, with: LineupEventEntity
        present :lineup_jobs, entry.jobs, with: LineupJobEntity
        present :lineup_ensembles, LineupEnsemble.in( id: entry.lineup_ensemble_ids ), with: LineupEnsembleEntity
      end

      #
      # PUT /:id
      #
      desc "update an existing lineup_entry"
      params do
        requires :lineup_entry, type: Hash do   
          optional :title
          optional :subtitle
          optional :description
          optional :categories
          optional :age
          optional :recommended_age
          optional :duration_min
          optional :num_breaks
          optional :lineup_ensemble_ids
        end
      end
      put '/:id' do
        authenticate!
        entry = LineupEntry.find params.id 
        error! "LineupEntryNotFound", 404 unless entry
        entry.update_attributes( declared(params)[:lineup_entry] )
        present :lineup_entry, entry.reload, with: LineupEntryEntity
        present :lineup_events, entry.events, with: LineupEventEntity
        present :lineup_jobs, entry.jobs, with: LineupJobEntity
        present :lineup_ensembles, LineupEnsemble.in( id: entry.lineup_ensemble_ids ), with: LineupEnsembleEntity
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