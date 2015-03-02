Caminio.LineupVenuesEditController = Ember.ObjectController.extend

  needs: ['application', 'sessions']

  venue: null

  actions:

    save: (callback, scope)->
      @get('venue')
        .save()
        .then =>
          if callback
            return callback.call(scope)
          noty
            type: 'success'
            text: Em.I18n.t('saved', name: @get('venue.title'))

    delete: ->
      console.log @get('venue')
      bootbox.confirm Em.I18n.t('lineup.venue.really_delete', name: @get('venue.title')), (proceed)=>
        return unless proceed
        @get('venue')
          .destroyRecord()
          .then ->
            noty
              text: Em.I18n.t('lineup.venue.deleted', name: @get('venue.title'))
              type: 'success'
            @transitionToRoute 'lineup_venues.index'