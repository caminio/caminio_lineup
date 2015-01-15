module Caminio
  module EventsHelper

    def get_parent!
      parent = LineupEntry.where(id: params.lineup_entry_id)
      parent = LineupFestival.where(id: params.lineup_festival_id) unless parent
      error! 'NoParentIdGiven', 400 unless parent
      parent.first
    end

  end
end