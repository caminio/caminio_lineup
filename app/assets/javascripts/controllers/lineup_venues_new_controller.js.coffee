Caminio.LineupVenuesNewController = Caminio.LineupVenuesEditController.extend

  controllers: ['lineup_venues_index']

  actions:

    save: (routeName)->
      @get('venue')
        .save()
        .then (venue)=>
          if @get('tableBridge.rows')
            @get('tableBridge.rows').pushObject( venue )
          noty
            type: 'success'
            text: Em.I18n.t('saved', name: venue.get 'title')
          if routeName
            @transitionToRoute routeName
          else
            @transitionToRoute 'lineup_venues.edit', venue.id