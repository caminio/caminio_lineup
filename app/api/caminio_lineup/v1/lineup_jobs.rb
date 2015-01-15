module Caminio

  module V1

    class LineupJobs < Grape::API

      default_format :json
      helpers Caminio::AuthHelper
      helpers LineupParentsHelper

      #
      # GET /
      #
      desc "lists all lineup_jobs"
      get do
        lineup_jobs = LineupJob.all
        present :lineup_jobs, lineup_jobs, with: LineupJobEntity
      end

      #
      # GET /:id
      #
      desc "returns lineup_job with :id"
      get ':id' do
        authenticate!
        job = LineupJob.where(id: params.id).first
        error!('NotFound',404) unless job
        present :lineup_job, job, with: LineupJobEntity
      end

      #
      # POST /
      #
      desc "create a new lineup_job"
      params do
        requires :lineup_job, type: Hash do
          optional :title
          optional :description
          optional :lineup_person_id
        end
      end
      post do
        authenticate!
        job = LineupJob.new( declared( params )[:lineup_job] )
        error!({ error: 'SavingFailed', details: job.errors.full_messages}, 422) unless job.save
        present :lineup_job, job, with: LineupJobEntity
      end

      #
      # PUT /:id
      #
      desc "update an existing lineup_job"
      params do
        requires :lineup_job, type: Hash do
          optional :title
          optional :description
          optional :lineup_person_id
        end
      end
      put '/:id' do
        authenticate!
        job = LineupJob.find params.id 
        error! "LineupJobNotFound", 404 unless job
        job.update_attributes( declared(params)[:lineup_job] )
        present :lineup_job, job.reload, with: LineupJobEntity
      end

      #
      # DELETE /:id
      #
      desc "delete an lineup_job"
      formatter :json, lambda{ |o,env| "{}" }
      delete '/:id' do
        authenticate!
        job = LineupJob.find params.id 
        error! "LineupJobNotFound", 404 unless job
        error!("DeletionFailed",500) unless job.destroy
      end

    end
  end
end