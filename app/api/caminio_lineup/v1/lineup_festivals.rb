module Caminio

  module V1

    class LineupFestivals < Grape::API

      default_format :json
      helpers Caminio::AuthHelper

      #
      # GET /
      #
      desc "lists all lineup_festivals"
      get do
        festivals = LineupFestival.all
        present :lineup_festivals, festivals, with: LineupFestivalEntity
      end

      #
      # GET /:id
      #
      desc "returns lineup_festival with :id"
      get ':id' do
        authenticate!
        festival = LineupFestival.where(id: params.id).first
        error!('NotFound',404) unless festival
        present :lineup_festival, festival, with: LineupFestivalEntity
      end

      #
      # POST /
      #
      desc "create a new lineup_festival"
      params do
        requires :lineup_festival, type: Hash do
          optional :title
          optional :description
        end
      end
      post do
        authenticate!
        festival = LineupFestival.new( declared( params )[:lineup_festival] )
        error!({ error: 'SavingFailed', details: festival.errors.full_messages}, 422) unless festival.save
        present :lineup_festival, festival, with: LineupFestivalEntity
      end

      #
      # PUT /:id
      #
      desc "update an existing lineup_festival"
      params do
        requires :lineup_festival, type: Hash do
          optional :title
          optional :description
        end
      end
      put '/:id' do
        authenticate!
        festival = LineupFestival.find params.id 
        error! "LineupFestivalNotFound", 404 unless festival
        festival.update_attributes( declared(params)[:lineup_festival] )
        present :lineup_festival, festival.reload, with: LineupFestivalEntity
      end

      #
      # DELETE /:id
      #
      desc "delete an lineup_festival"
      formatter :json, lambda{ |o,env| "{}" }
      delete '/:id' do
        authenticate!
        festival = LineupFestival.find params.id 
        error! "LineupFestivalNotFound", 404 unless festival
        error!("DeletionFailed",500) unless festival.destroy
      end

    end
  end
end