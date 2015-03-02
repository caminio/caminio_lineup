#
# INDEX
#
Caminio.LineupVenuesIndexRoute = Caminio.AuthenticatedRoute.extend

  model: ->
    @store.find 'lineup_venue'

#
# EDIT
#
Caminio.LineupVenuesEditRoute = Caminio.LineupVenuesIndexRoute.extend

  model: (params)->
    @store
      .find 'lineup_venue', params.id
      .then (venue)=>
        @controllerFor('lineup_venues_edit').set 'venue', venue
    @_super()

  renderTemplate: (controller)->
    indexController = @controllerFor 'lineup_venues_index'
    indexController.set 'content', controller.get 'content'
    @render 'lineup_venues.index',
      controller: indexController
    @render 'lineup_venues.edit',
      outlet: 'modal'

  actions:
    willTransition: (transition)->
      if Caminio.get('lastPath')
        @transitionTo Caminio.get('lastPath')

#
# NEW
#
Caminio.LineupVenuesNewRoute = Caminio.LineupVenuesIndexRoute.extend

  setupController: (controller,model)->
    @_super controller, model
    org = @controllerFor('application').get('currentOrganization')
    controller.set 'venue',
      @store.createRecord 'lineup_venue',
        organization: org,
        locale: Em.I18n.locale

  renderTemplate: (controller)->
    indexController = @controllerFor 'lineup_index'
    indexController.set 'content', controller.get 'content'
    @render 'lineup_venues.index',
      controller: indexController
    @render 'lineup_venues.new',
      outlet: 'modal'

  willTransition: (transition)->
    if @get('controller.lineup_venue.isNew')
      @get('controller.lineup_venue').destroyRecord()
    true

