class LineupVenue < Location
  
  include LineupAttributes

  field :reach_by_bus, type: String
  field :reach_by_tram, type: String
  field :reach_by_train, type: String
  field :opening_hours, type: String

  before_destroy :destroy_events

  private

    def destroy_events
      LineupEntry.elem_match( events: { lineup_venue_id: self.id } ).each do |entry|
        entry.events.each { |event| event.destroy if event.lineup_venue_id == self.id }
      end
    end 

  
end
