Caminio.LineupEntry = DS.Model.extend
  title:                DS.attr 'string'
  subtitle:             DS.attr 'string'
  description:          DS.attr 'string'
  categories:           DS.attr 'array'

  age:                  DS.attr 'number'
  duration_min:         DS.attr 'number'
  num_breaks:           DS.attr 'number'

  lineup_events:        DS.hasMany 'lineup_events'