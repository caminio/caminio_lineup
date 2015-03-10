Em.I18n.availableTranslations ||= {}
Em.I18n.availableTranslations.de ||= {}

Em.merge Em.I18n.availableTranslations.de,
  lineup:
    venue:
      search: 'Ort suchen'
      new: 'Neuer Veranstaltungsort'
      edit: 'Veranstaltungsort bearbeiten'
      title: 'Veranstaltungsort'
      delete: 'Veranstaltungsort löschen'
      really_delete: 'Möchten Sie den Veranstaltungsort &raquo;{{name}}&laquo; wirklich löschen?'
      deleted: 'Veranstaltungsort &raquo;{{name}}&laquo; wurde gelöscht'
    venues:
      title: 'Veranstaltungsorte'
    entries:
      title: 'Veranstaltungen'
    events:
      title: 'Veranstaltungstermine'
      multiple: 'Terminserie bearbeiten'
    event:
      add: 'Termin hinzufügen'
    series_walkthrough:
      title: 'Hilfe zur Verwaltung von Terminserien'
      toggle_btn: 'Dies ist eine kurze Einführung in die Verwendung von Terminserien. <br><br>Wenn die Veranstaltung noch keine Termine enthält, wird das Formular zum Hinzufügen der Termine automatisch geöffnet. <br><br>Befinden sich schon Termine in der Veranstaltung, können Sie mit dem Plus-Symbol bzw. dem Pfeil die Formularmaske aus- und einblenden.'
      select_venue: 'Sie können diese Maske sehr effizient verwenden und zügig Termine eintragen. <br><br>Wählen Sie einmalig einen Veranstaltungsort.'
      select_time: 'Und eine Zeit (sofern diese gleich bleibt)'
      select_date: 'Jetzt klicken Sie auf die entsprechenden Tage und pro Klick wird der Termin mit den gewählen Optionen angelegt. Praktisch, oder?'
      start_again: 'Sie können durch klicken auf das Hilfesymbol diese Hilfe jederzeit wieder anzeigen.'