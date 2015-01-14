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
        error!('NotFound',404) unless ensemble
        present :lineup_ensemble, ensemble, with: LineupEnsembleEntity
      end

      #
      # POST /
      #
      desc "create a new lineup_ensemble"
      params do
        requires :lineup_ensemble, type: Hash do
          optional :title
          optional :description
        end
      end
      post do
        authenticate!
        ensemble = LineupEnsemble.new( declared( params )[:lineup_ensemble] )
        error!({ error: 'SavingFailed', details: ensemble.errors.full_messages}, 422) unless ensemble.save
        present :lineup_ensemble, ensemble, with: LineupEnsembleEntity
      end

      #
      # PUT /:id
      #
      desc "update an existing lineup_ensemble"
      params do
        requires :lineup_ensemble, type: Hash do
          optional :title
          optional :description
        end
      end
      put '/:id' do
        authenticate!
        ensemble = LineupEnsemble.find params.id 
        error! "LineupEnsembleNotFound", 404 unless ensemble
        ensemble.update_attributes( declared(params)[:lineup_ensemble] )
        present :lineup_ensemble, ensemble.reload, with: LineupEnsembleEntity
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