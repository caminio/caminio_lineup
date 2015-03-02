Caminio.LineupVenuesNewController = Caminio.LineupVenuesEditController.extend  

  actions:

    save: ->
      @get('venue')
        .save()
        .then (venue)=>
          noty
            type: 'success'
            text: Em.I18n.t('saved', name: venue.get 'title')
          @transitionToRoute 'lineup_venues.edit', venue.id