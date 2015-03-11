Caminio.LineupSeriesWalkthrough =
  start: (finished)->
    tour = new Tour
      template: tooltipTourTemplate
      storage: false
      steps: [
        {
          placement: 'right'
          element: ".modal-header .toggle-form-btn"
          title: Em.I18n.t('lineup.series_walkthrough.title')
          content: Em.I18n.t('lineup.series_walkthrough.toggle_btn')
          onNext: (tour)->
            unless $('.new-event-form').is(':visible')
              $('.modal-header .toggle-form-btn').click()
        }
        {
          placement: 'right'
          element: ".new-event-form input.select-venue"
          title: Em.I18n.t('lineup.series_walkthrough.title')
          content: Em.I18n.t('lineup.series_walkthrough.select_venue')
        }
        {
          placement: 'right'
          element: ".new-event-form input.timepicker"
          title: Em.I18n.t('lineup.series_walkthrough.title')
          content: Em.I18n.t('lineup.series_walkthrough.select_time')
        }
        {
          placement: 'right'
          element: ".new-event-form .pika-single"
          title: Em.I18n.t('lineup.series_walkthrough.title')
          content: Em.I18n.t('lineup.series_walkthrough.select_date')
        }
        {
          placement: 'right'
          element: ".start-again"
          title: Em.I18n.t('lineup.series_walkthrough.title')
          content: Em.I18n.t('lineup.series_walkthrough.start_again')
        }
      ]
      onEnd: finished
    tour.init()
    tour.start()