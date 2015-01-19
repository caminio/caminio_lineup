module Caminio

  module V1

    class LineupPersons < Grape::API

      default_format :json
      helpers Caminio::AuthHelper

      #
      # GET /
      #
      desc "lists all lineup_persons"
      get do
        lineup_persons = LineupPerson.all
        present :lineup_persons, lineup_persons, with: LineupPersonEntity
      end

      #
      # GET /:id
      #
      desc "returns lineup_person with :id"
      get ':id' do
        authenticate!
        person = LineupPerson.where(id: params.id).first
        location = Location.where( id: person[:location_id] ).first
        error!('NotFound',404) unless person
        present :lineup_person, person, with: LineupPersonEntity
        present :lineup_ensembles, LineupEnsemble.in( id: person.lineup_ensemble_ids ), with: LineupEnsembleEntity
        present :location, location, with: LocationEntity
      end

      #
      # POST /
      #
      desc "create a new lineup_person"
      params do
        requires :lineup_person, type: Hash do
          optional :firstname
          optional :midname
          optional :lastname
          optional :email
          optional :phone
          optional :position
          optional :tags
          optional :ext_ref_id
          optional :ext_ref_src
          optional :ext_ref_note
          optional :ext_ref_sync_at
          optional :orig_url
          optional :ext_url
          optional :video_url
          optional :video_type
          optional :others_write
          optional :notify_me_on_write
          optional :lineup_ensemble_ids
          optional :location_id
        end
      end
      post do
        authenticate!
        person = LineupPerson.new( declared( params )[:lineup_person] )
        error!({ error: 'SavingFailed', details: person.errors.full_messages}, 422) unless person.save
        location = Location.where( id: person[:location_id] ).first
        present :lineup_person, person, with: LineupPersonEntity
        present :lineup_ensembles, LineupEnsemble.in( id: person.lineup_ensemble_ids ), with: LineupEnsembleEntity
        present :location, location, with: LocationEntity
      end

      #
      # PUT /:id
      #
      desc "update an existing lineup_person"
      params do
        requires :lineup_person, type: Hash do
          optional :firstname
          optional :midname
          optional :lastname
          optional :email
          optional :phone
          optional :position
          optional :tags
          optional :ext_ref_id
          optional :ext_ref_src
          optional :ext_ref_note
          optional :ext_ref_sync_at
          optional :orig_url
          optional :ext_url
          optional :video_url
          optional :video_type
          optional :others_write
          optional :notify_me_on_write
          optional :lineup_ensemble_ids
          optional :location_id
        end
      end
      put '/:id' do
        authenticate!
        person = LineupPerson.find params.id 
        error! "LineupPersonNotFound", 404 unless person
        person.update_attributes( declared(params)[:lineup_person] )
        location = Location.where( id: params.lineup_person[:location_id] ).first
        present :lineup_person, person.reload, with: LineupPersonEntity
        present :lineup_ensembles, LineupEnsemble.in( id: person.lineup_ensemble_ids ), with: LineupEnsembleEntity
        present :location, location, with: LocationEntity
      end

      #
      # DELETE /:id
      #
      desc "delete an lineup_person"
      formatter :json, lambda{ |o,env| "{}" }
      delete '/:id' do
        authenticate!
        person = LineupPerson.find params.id 
        error! "LineupPersonNotFound", 404 unless person
        error!("DeletionFailed",500) unless person.destroy
      end

    end
  end
end