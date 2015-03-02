#= require_tree './locales'
#= require_tree './routes'
#= require_tree './models'
#= require_tree './controllers'
#= require_tree './templates'
#= require_tree './views'
#= require_self

Caminio.Router.map ->
  @resource 'lineup', ->
    @route 'index'

  @resource 'lineup_venues', ->
    @route 'new'
    @route 'index'
    @route 'edit', path: ':id'

  @resource 'lineup_entries', ->
    @route 'new'
    @route 'index'
    @route 'edit', path: ':id'