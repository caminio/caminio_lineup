module Caminio

  module V1

    class LineupVenues < Grape::API

      default_format :json
      helpers Caminio::AuthHelper

      #
      # GET /
      #
      desc "lists all lineup_venues"
      get do
        lineup_venues = LineupVenue.all
        present :lineup_venues, lineup_venues, with: LineupVenueEntity
      end

      #
      # GET /:id
      #
      desc "returns lineup_venue with :id"
      get ':id' do
        authenticate!
        venue = LineupVenue.where(id: params.id).first
        error!('NotFound',404) unless venue
        present :lineup_venue, venue, with: LineupVenueEntity
      end

      #
      # POST /
      #
      desc "create a new lineup_venue"
      params do
        requires :lineup_venue, type: Hash do
          requires :title
          optional :opening_hours
          optional :reach_by_bus
          optional :reach_by_tram
          optional :reach_by_train
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
          
          optional :description
          optional :street
          optional :zip
          optional :city
          optional :country_code
          optional :state
          optional :building
          optional :stair
          optional :floor
          optional :room
          optional :gkz
          optional :addition
          optional :lat
          optional :lng
          optional :url
          optional :phone
          optional :email
        end
      end
      post do
        authenticate!
        venue = LineupVenue.new( declared( params )[:lineup_venue] )
        error!({ error: 'SavingFailed', details: venue.errors.full_messages}, 422) unless venue.save
        present :lineup_venue, venue, with: LineupVenueEntity
      end

      #
      # PUT /:id
      #
      desc "update an existing lineup_venue"
      params do
        requires :lineup_venue, type: Hash do
          optional :opening_hours
          optional :reach_by_bus
          optional :reach_by_tram
          optional :reach_by_train
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
          
          optional :title
          optional :description
          optional :street
          optional :zip
          optional :city
          optional :country_code
          optional :state
          optional :building
          optional :stair
          optional :floor
          optional :room
          optional :gkz
          optional :addition
          optional :lat
          optional :lng
          optional :url
          optional :phone
          optional :email
        end
      end
      put '/:id' do
        authenticate!
        venue = LineupVenue.find params.id 
        error! "LineupVenueNotFound", 404 unless venue
        venue.update_attributes( declared(params)[:lineup_venue] )
        present :lineup_venue, venue.reload, with: LineupVenueEntity
      end

      #
      # DELETE /:id
      #
      desc "delete an lineup_venue"
      formatter :json, lambda{ |o,env| "{}" }
      delete '/:id' do
        authenticate!
        venue = LineupVenue.find params.id 
        error! "LineupVenueNotFound", 404 unless venue
        error!("DeletionFailed",500) unless venue.destroy
      end

    end
  end
end