Caminio.ClickEditEventsComponent = Ember.Component.extend

  venue: null
  starts: moment().add(1,'h').minutes(0).toDate()

  saveClickComponent: (e)->
    return unless $('.editing-click-form').length
    return if $(e.target).hasClass('.editing-click-form')
    return if $(e.target).closest('.editing-click-form').length
    @send 'saveChanges'

  init: ->
    @_super()
    @set('origValue', '')
    @set('origValue', @get('value')) unless Em.isEmpty(@get('value'))
    @set('value','') if Em.isEmpty(@get('value'))
    
    $(document)
      .off('click', $.proxy(@saveClickComponent, @))
      .on('click', $.proxy(@saveClickComponent, @))

    if @get('focus')
      @set('editValue', true)
      Caminio.set('currentClickEdit', @)
      Em.run.later (-> @$('input:first').focus()), 500

  saveActionName: 'save'

  timeValue: ((key,val)->
    return moment().format('HH')+':00' if !val && !@get('starts')
    if arguments.length > 1
      @set 'starts', moment() unless @get('starts')
      @set 'starts', moment(@get('starts')).hours(val.split(':')[0]).minutes(val.split(':')[1]).toDate()
    moment(@get('starts')).format('HH:mm')
  ).property 'starts'

  dateValue: ((key,val)->
    return moment().format('DD-MM-YYYY') if !val && !@get('value')
    hours = moment().format('HH')
    minutes = 0
    if @get 'starts'
      hours = moment(@get('starts')).hours()
      minutes = moment(@get('starts')).minutes()
    if arguments.length > 1
      d = moment(val, 'DD-MM-YYYY')
      d.hours(hours) if hours
      d.minutes(minutes) if hours
      @set 'starts', d.toDate()
    moment(@get('starts')).format('DD-MM-YYYY')
  ).property 'starts'

  monthValue: (->
    moment(@get('value')).format('MMMM')
  ).property 'value'

  dayNum: (->
    moment(@get('value')).format('DD')
  ).property 'value'

  yearValue: (->
    moment(@get('value')).format('YYYY')
  ).property 'value'

  formattedDate: (->
    "#{moment(@get('value')).format('dddd, HH:mm')} #{Em.I18n.t('o_clock')}"
  ).property 'value'

  editValue: false
  valueSaved: false
  valueSaving: false

  labelTranslation: Em.computed ->
    Em.I18n.t( @get('label') )

  editValueObserver: (->
    Em.run.later =>
      @$('input[type=text]').focus()
    , 10
  ).observes 'editValue'

  hasChanges: Em.computed ->
    @get('origValue') != @get('value')
  .property 'origValue', 'value'

  valueObserver: (->
    return if @get('origValue') == @get('value')
  ).observes 'value'

  showQuickEventForm: false

  saveCallback: ->
    @set('editValue',false)
    @set('valueSaving', false)
    @set('valueSaved', true)
    Ember.run.later =>
      @set('valueSaved',false)
      @set('origValue', @get('value'))
    , 2000

  didInsertElement: ->
    @$('.datepicker').pikaday
      firstDay: 1
      format: 'DD-MM-YYYY'
      minDate: new Date()
      i18n: Pikaday.lang

    @$('.timepicker').timeEntry
      timeSteps: [1, 15, 0]

    venue = @get('targetObject.content.lineup_venue')
    venue = @get('targetObject.content.ticketeer_venue') unless venue
    @set('venue', venue)

  lineupEvents: (->
    content = @get('targetObject.content')
    events = []
    events = content.get('lineup_events') if content.get('lineup_events')
    events = content.get('lineup_entry.lineup_events') if content.get('lineup_entry')
    events
  ).property 'targetObject.content'

  availableVenues: Em.A()

  selectEvent: (date)->
    entry = @get('targetObject.lineup_entry')
    events = entry.get('lineup_events')
    lineupEvent = @get('targetObject').store.createRecord 'lineup_event', starts: date, lineup_venue: @get('venue'), lineup_entry: entry
        
  setupQuickEventForm: (modal)->
    $(modal).find('.datepicker').pikaday
      firstDay: 1
      format: 'DD-MM-YYYY'
      minDate: new Date()
      i18n: Pikaday.lang
      bound: false
      onSelect: $.proxy( @selectEvent, @ )

    $(modal).find('.timepicker').timeEntry
      timeSteps: [1, 15, 0]

    # because of animate.css animation 500ms
    Em.run.later =>
      user = @get('targetObject.controllers.application.currentUser')
      @send 'startTour' if user.get('completed_tours').indexOf('lineup_series') < 0
    , 500

  actions:

    saveChanges: ->
      content = @get('content') || @get('targetObject.content')
      if content.get 'isNew'
        return @set 'editValue', false
      @set('valueSaving', true)
      @get('targetObject').send(@get('saveActionName'), @saveCallback, @)

    cancelEdit: ->
      @set('editValue',false)
      @set('value', @get('origValue'))
      Caminio.get('currentClickEdit', null)

    edit: ->
      return if @get('editValue')
      other = Caminio.get('currentClickEdit') 
      if other && !other.isDestroyed && other != @
        other.set('editValue',false)
      @set('editValue', true)
      Caminio.set('currentClickEdit', @)
      Em.run.later =>
        @$('input:first').focus()
      , 300

    startTour: ->
      user = @get('targetObject.controllers.application.currentUser')
      Caminio.LineupSeriesWalkthrough.start ->
        return if user.get('completed_tours').indexOf('lineup_series') >= 0
        user.get('completed_tours').push 'lineup_series'
        user.save()

    toggleForm: ->
      @toggleProperty 'showQuickEventForm'

    editEvents: ->
      content = @get('content') || @get('targetObject.content')
      
      @get('targetObject').send 'openMiniModal', 'select_events_for_click_edit', @, (modal)=>

        @set 'showQuickEventForm', true if content.get('lineup_entry.lineup_events.length') < 1

        @setupQuickEventForm(modal)

Caminio.SelectEventsItemController = Ember.ObjectController.extend
  
  actions:

    save: ->
      console.log 'here save in select_events_item_controller'