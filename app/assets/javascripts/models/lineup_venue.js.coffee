Caminio.LineupVenue = Caminio.Location.extend
  reach_by_bus:                   DS.attr('string')
  reach_by_tram:                  DS.attr('string')
  reach_by_train:                 DS.attr('string')
  opening_hours:                  DS.attr('string')

  ext_ref_src:                    DS.attr 'string'
  ext_ref_id:                     DS.attr 'string'
  ext_ref_note:                   DS.attr 'string'
  ext_ref_sync_at:                DS.attr 'date'

  ext_url:                        DS.attr 'string'
  orig_url:                       DS.attr 'string'
  video_url:                      DS.attr 'string'

  video_type:                     DS.attr 'string'
  others_write:                   DS.attr 'boolean', defaultValue: true
  notify_me_on_write:             DS.attr 'boolean', defaultValue: true