Caminio.LineupVenuesIndexController = Ember.ObjectController.extend

  needs: ['application']

  filter: ''

  rootLevel: true
  
  sortProperties: ['name']
  sortAscending: true

  page: 0
  perPage: 25
  showPaginationPages: 5

  filterFilds: {}

  navToStart: (->
    @get('page') > (@get('show_pagination_pages') * 2 + 1)
  ).property 'pages', 'per_page', 'page'

  navToEnd: (->
    @get('page') + (@get('show_pagination_pages') * 2 + 1) < @get('total_pages')
  ).property 'pages', 'per_page', 'page'

  loadData: ->
    data = 
      page: @get('page')
      per_page: @get('perPage')
      sort_asc: @get('sortAsc')
      sort_desc: @get('sortDesc')
      filter: @get('filterFields')

    if @get('selected_labels.length') > 0
      data.label_ids = @get('selected_labels').map (label)-> label.id

    Ember.$.ajax
      url: '/caminio/contacts/table_data'
      type: 'post'
      data: data

    .then (model)=>
      model.data = model.data.map( (d)=> d.selected = @get('selected_row_ids').contains(d.id); d )
      @set('content', Em.A( model.data.map( (d)-> Ember.Object.create(d) ) ))
      @set('total', model.total)
      @set('pages', new Array(model.total_pages))
      @set('total_pages', model.total_pages)

