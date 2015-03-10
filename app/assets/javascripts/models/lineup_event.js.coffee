Caminio.LineupEvent = DS.Model.extend
  starts:                          DS.attr('date')
  note:                            DS.attr 'string'
  
  lineup_venue:                    DS.belongsTo('lineup_venue')
  lineup_entry:                    DS.belongsTo('lineup_entry')
