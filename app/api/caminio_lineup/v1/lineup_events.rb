module Caminio

  module V1

    class LineupEvents < Grape::API

      default_format :json
      helpers Caminio::AuthHelper
      helpers EventsHelper

      #
      # GET /
      #
      # desc "lists all lineup_events"
      # get do
      #   events = LineupEvent.all
      #   present :lineup_events, events, with: LineupEventEntity
      # end

      #
      # GET /:id
      #
      # desc "returns lineup_event with :id"
      # get ':id' do
      #   authenticate!
      #   puts LineupEntry.first.events.inspect
      #   event = LineupEvent.where(id: params.id).first
      #   error!('NotFound',404) unless event
      #   present :lineup_event, event, with: LineupEventEntity
      # end

      #
      # POST /
      #
      desc "create a new lineup_event"
      params do
        requires :lineup_event, type: Hash do
          optional :starts
          optional :note
          optional :book_phone
          optional :book_email
          optional :book_url
          optional :concessions
          optional :premiere
          optional :derniere
          optional :cancelled
        end
        optional :lineup_entry_id
        optional :lineup_festival_id
      end
      post do
        authenticate!
        parent = get_parent!
        event = parent.events.new( declared( params )[:lineup_event] )
        error!({ error: 'SavingFailed', details: event.errors.full_messages}, 422) unless event.save
        present :lineup_event, event, with: LineupEventEntity
        present_parent parent
      end

      #
      # PUT /:id
      #
      desc "update an existing lineup_event"
      params do
        requires :lineup_event, type: Hash do
          optional :starts
          optional :note
          optional :book_phone
          optional :book_email
          optional :book_url
          optional :concessions
          optional :premiere
          optional :derniere
          optional :cancelled
        end
        optional :lineup_entry_id
        optional :lineup_festival_id
      end
      put '/:id' do
        authenticate!
        parent = get_parent!
        event = parent.events.where( id: params.id ).first
        error! "LineupEventNotFound", 404 unless event
        event.update_attributes( declared(params)[:lineup_event] )
        present :lineup_event, event.reload, with: LineupEventEntity
      end

      #
      # DELETE /:id
      #
      params do
        optional :lineup_entry_id
        optional :lineup_festival_id
      end
      desc "delete an lineup_event"
      formatter :json, lambda{ |o,env| "{}" }
      delete '/:id' do
        authenticate!
        parent = get_parent!
        event = parent.events.where( id: params.id ).first
        error! "LineupEventNotFound", 404 unless event
        error!("DeletionFailed",500) unless event.destroy
      end

    end
  end
end