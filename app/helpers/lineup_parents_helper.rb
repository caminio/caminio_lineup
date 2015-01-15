module Caminio
  module LineupParentsHelper

    def get_parent!
      parent = LineupEntry.where(id: params.lineup_entry_id)
      parent = LineupFestival.where(id: params.lineup_festival_id) unless parent
      error! 'NoParentIdGiven', 400 unless parent
      parent.first
    end

    def present_parent parent
       name = parent.class.name
       if name == "LineupEntry"
        present :lineup_entry, parent, with: LineupEntryEntity
      else
        present :lineup_festival, parent, with: LineupFestivalEntity
      end
    end

  end
end