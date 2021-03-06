module Caminio

  module V1

    class LineupEnsembles < Grape::API

      default_format :json
      helpers Caminio::AuthHelper

      #
      # GET /
      #
      desc "lists all lineup_ensembles"
      get do
        ensembles = LineupEnsemble.all
        present :lineup_ensembles, ensembles, with: LineupEnsembleEntity
      end

      #
      # GET /:id
      #
      desc "returns lineup_ensemble with :id"
      get ':id' do
        authenticate!
        ensemble = LineupEnsemble.where(id: params.id).first
        location = Location.where( id: ensemble[:location_id] ).first
        error!('NotFound',404) unless ensemble
        present :lineup_ensemble, ensemble, with: LineupEnsembleEntity
        present :lineup_entries, LineupEntry.in( id: ensemble.lineup_entry_ids ), with: LineupEntryEntity
        present :lineup_persons, LineupPerson.in( id: ensemble.lineup_person_ids ), with: LineupPersonEntity
        present :location, location, with: LocationEntity
      end

      #
      # POST /
      #
      desc "create a new lineup_ensemble"
      params do
        requires :lineup_ensemble, type: Hash do
          optional :title
          optional :description
          optional :lineup_entry_ids
          optional :lineup_person_ids
          optional :location_id
        end
      end
      post do
        authenticate!
        ensemble = LineupEnsemble.new( declared( params )[:lineup_ensemble] )
        location = Location.where( id: params.lineup_ensemble[:location_id] ).first
        error!({ error: 'SavingFailed', details: ensemble.errors.full_messages}, 422) unless ensemble.save
        present :lineup_ensemble, ensemble, with: LineupEnsembleEntity
        present :lineup_entries, LineupEntry.in( id: ensemble.lineup_entry_ids ), with: LineupEntryEntity
        present :lineup_persons, LineupPerson.in( id: ensemble.lineup_person_ids ), with: LineupPersonEntity
        present :location, location, with: LocationEntity
      end

      #
      # PUT /:id
      #
      desc "update an existing lineup_ensemble"
      params do
        requires :lineup_ensemble, type: Hash do
          optional :title
          optional :description
          optional :lineup_entry_ids
          optional :lineup_person_ids
          optional :location_id
        end
      end
      put '/:id' do
        authenticate!
        ensemble = LineupEnsemble.find params.id 
        location = Location.where( id: params.lineup_ensemble[:location_id] ).first
        error! "LineupEnsembleNotFound", 404 unless ensemble
        ensemble.update_attributes( declared(params)[:lineup_ensemble] )
        present :lineup_ensemble, ensemble.reload, with: LineupEnsembleEntity
        present :lineup_entries, LineupEntry.in( id: ensemble.lineup_entry_ids ), with: LineupEntryEntity
        present :lineup_persons, LineupPerson.in( id: ensemble.lineup_person_ids ), with: LineupPersonEntity
        present :location, location, with: LocationEntity
      end

      #
      # DELETE /:id
      #
      desc "delete an lineup_ensemble"
      formatter :json, lambda{ |o,env| "{}" }
      delete '/:id' do
        authenticate!
        ensemble = LineupEnsemble.find params.id 
        error! "LineupEnsembleNotFound", 404 unless ensemble
        error!("DeletionFailed",500) unless ensemble.destroy
      end

    end
  end
end