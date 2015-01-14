module Caminio

  module V1

    class LineupEvents < Grape::API

      default_format :json
      helpers Caminio::AuthHelper

      #
      # GET /
      #
      desc "lists all lineup_events"
      get do
        events = LineupEvent.all
        present :lineup_events, events, with: LineupEventEntity
      end

      #
      # GET /:id
      #
      desc "returns lineup_event with :id"
      get ':id' do
        authenticate!
        event = LineupEvent.where(id: params.id).first
        error!('NotFound',404) unless event
        present :lineup_event, event, with: LineupEventEntity
      end

      #
      # POST /
      #
      desc "create a new lineup_event"
      params do
        requires :lineup_event, type: Hash do
          optional :starts
        end
      end
      post do
        authenticate!
        event = LineupEvent.new( declared( params )[:lineup_event] )
        error!({ error: 'SavingFailed', details: event.errors.full_messages}, 422) unless event.save
        present :lineup_event, event, with: LineupEventEntity
      end

      #
      # PUT /:id
      #
      desc "update an existing lineup_event"
      params do
        requires :lineup_event, type: Hash do
          optional :starts
        end
      end
      put '/:id' do
        authenticate!
        event = LineupEvent.find params.id 
        error! "LineupEventNotFound", 404 unless event
        event.update_attributes( declared(params)[:lineup_event] )
        present :lineup_event, event.reload, with: LineupEventEntity
      end

      #
      # DELETE /:id
      #
      desc "delete an lineup_event"
      formatter :json, lambda{ |o,env| "{}" }
      delete '/:id' do
        authenticate!
        event = LineupEvent.find params.id 
        error! "LineupEventNotFound", 404 unless event
        error!("DeletionFailed",500) unless event.destroy
      end

    end
  end
end